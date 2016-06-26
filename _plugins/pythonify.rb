require 'pry'
module Jekyll
  module PythonifyFilter
    def pythonify(input)
      buf = ''
      input.each do |key, val|
        buf << "<span class='gp'>>>></span> #{key}<br>"
        pythonify_inner(val, buf, 0)
        buf << '<br><br>'
      end
      buf.sub('<br>', '<br>\n') # for readability
      buf[0..-5] # slice of unnecessary last <br>
    end

    private

    def indent(input, count)
      "<div class='indent#{count}'>#{input}</div>"
    end

    def pythonify_inner(input, buf, ind, first_hash=true)
      if input.is_a?(Hash)
        buf << (first_hash ? indent('{', ind) : '{')
        buf << '<br>'
        input.each do |key, val|
          buf << indent("<span class='nn'>#{key}</span>:&nbsp;", ind + 1)
          pythonify_inner(val, buf, ind + 1)
          buf << ',<br>'
        end
        buf << indent('}', ind)
      elsif input.is_a?(Array)
        buf << '['

        next_ind = ind
        if input.first.is_a?(Hash)
          buf << '<br>'
          next_ind += 1
        end

        input.each_with_index do |e, i|
          pythonify_inner(e, buf, next_ind, i == 0)
          buf << ', ' unless i == input.length - 1
        end

        next_ind = ind
        buf << '<br>' if input[0].is_a?(Hash)
        buf << ']'
      else
        buf << "'<span class='s'>#{stripp(markdownify(input))}</span>'"
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::PythonifyFilter)
