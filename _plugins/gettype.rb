module Jekyll
    module GetTypeFilter
        def gettype(input)
            return input.class.to_s
        end
    end
end

Liquid::Template.register_filter(Jekyll::GetTypeFilter)
