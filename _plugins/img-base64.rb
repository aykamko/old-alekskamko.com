# A Liquid tag for base64 encoding
# Author: Fabrizio Calderan (@fcalderan), 2015-09-25. 
# Last update: 2015-10-14
# License: CC BY-SA 4.0 (https://creativecommons.org/licenses/by-sa/4.0/)
#
# Note - this plugin uses Colorize: https://github.com/fazibear/colorize
# (sudo gem install colorize)
# ---
# Usage example: you can transform this code
#      <img src="images/FTF15.jpg" alt="A photo of From The Front Conference, 2015 edition" />
#
# into:
#      <img src="{% base64 images/FTF15.jpg %}"
#           alt="A photo of From The Front Conference, 2015 edition" />
#
# You can even pass a variable as the argument to the tag, e.g. when the
# image src must be interpolated with another variable:
#
#      {% capture jpeg %}images/{{ image }}.jpg{% endcapture %}
#      <img src="{% base64 jpeg %}" alt="..." />

require 'open-uri'
require 'pathname'
require 'base64'

module Jekyll
    class Base64Encoding < Liquid::Tag

        def initialize(tag_name, params, tokens)
            super
            @pad = " " * 6
            @imgsrc = params.strip
        end


        def getEncodingStatus(msg)
            puts "\n" + @pad + msg + @abspath.to_s
            puts @pad + "in " + @cs[:page]["path"] + "."
        end


        def getSizeStats()
            base64Size   = @dataURI.length
            originalSize = File.size(@abspath)
            inc          = (100 * base64Size / originalSize) - 100

            puts @pad + "=> Original size : ".green + originalSize.to_s
            puts @pad + "=> Base64 size: ".green + base64Size.to_s + " [+" + inc.to_s + "%]"
        end


        def render(context)

            # Get base path of html template
            @cs = context.registers

            # If a variable was passed to the liquid tag instead of a string
            # then read its value
            if context[@markup.strip]
                @imgsrc = context[@markup.strip]
            end

            basepath = @cs[:site].source

            # if a relative url was defined then the basepath is the same
            # of the page in which the image was requested.
            if (@imgsrc.chars.first != "/")
                basepath += @cs[:page]["dir"]
            end

            @abspath = Pathname.new(File.join(basepath,  @imgsrc))

            if File.exist?(@abspath)

                # Open file in read mode
                image = File.open(@abspath, "r")

                # Get the content of the file as a string
                imgstring = ""
                image.each { |line| imgstring << line }

                # Get image extension (e.g. ".png")
                imageext = File.extname(@imgsrc).gsub(/(\.\w+).*/, '\1').downcase;

                # Generate dataURI schema
                @dataURI = "data:image/";

                case imageext
                   when ".jpg"
                     @dataURI += "jpeg"
                   when ".svg"
                     @dataURI += "svg+xml"
                   else
                     # the MIME type is finally inferred from the file extension
                     @dataURI += imageext.gsub('.', '')
                end

                @dataURI += ";base64,"

                # yay, we encode it
                @dataURI += Base64.strict_encode64(imgstring)

                getEncodingStatus("Encoded: ".green)
                getSizeStats()

                @dataURI

            else

                getEncodingStatus("Warning: not found ".yellow)

            end
        end
    end
end

Liquid::Template.register_tag('base64', Jekyll::Base64Encoding)
