require 'pry'
module Jekyll
  module RubifyFilter
    def rubify(input)
      buf = ''
      input.each do |key, val|
        buf << "<span class='gp'>>>></span> #{key}<br>"
        rubify_inner(val, buf, 0)
        buf << '<br><br>'
      end
      buf.sub('<br>', '<br>\n') # for readability
      buf[0..-5] # slice of unnecessary last <br>
    end

    private

    def indent(input, count)
      "<div class='indent#{count}'>#{input}</div>"
    end

    def rubify_inner(input, buf, ind, first_hash=true)
      if input.is_a?(Hash)
        buf << (first_hash ? indent('{', ind) : '{')
        buf << '<br>'
        input.each do |key, val|
          buf << indent("<span class='nn'>#{key}</span>:&nbsp;", ind + 1)
          rubify_inner(val, buf, ind + 1)
          buf << ',<br>'
        end
        buf << indent('}', ind)
      elsif input.is_a?(Array)
        buf << '['

        input.each_with_index do |e, i|
          rubify_inner(e, buf, ind, i == 0)
          buf << ', ' unless i == input.length - 1
        end

        buf << ']'
      else
        buf << "'<span class='s'>#{stripp(markdownify(input))}</span>'"
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::RubifyFilter)
