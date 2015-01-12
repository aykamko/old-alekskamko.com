module Jekyll
    module StripPFilter
        def stripp(input)
            return input.strip.gsub(/<\/p>$/, '').gsub(/^<p>/, '')
        end
    end
end

Liquid::Template.register_filter(Jekyll::StripPFilter)
