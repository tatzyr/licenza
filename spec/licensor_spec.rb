require 'spec_helper'

describe Licensor do
  it 'has a version number' do
    expect(Licensor::VERSION).not_to be_nil
  end

  describe Licensor::Template do
    let(:template) { Licensor::Template.new }

    describe "#render" do
      it "should throw an ArgumentError if given license is unsupported" do
        expect { template.render("abc", "John Doe", "2015") }.to raise_error(ArgumentError)
        expect { template.render("", "John Doe", "2015") }.to raise_error(ArgumentError)
      end

      it "should return license text of given license" do
        zlib = <<-EOS.undent
        The zlib license (Zlib)

        Copyright (c) 2015 John Doe

        This software is provided 'as-is', without any express or implied
        warranty. In no event will the authors be held liable for any damages
        arising from the use of this software.

        Permission is granted to anyone to use this software for any purpose,
        including commercial applications, and to alter it and redistribute it
        freely, subject to the following restrictions:

           1. The origin of this software must not be misrepresented; you must not
           claim that you wrote the original software. If you use this software
           in a product, an acknowledgment in the product documentation would be
           appreciated but is not required.

           2. Altered source versions must be plainly marked as such, and must not be
           misrepresented as being the original software.

           3. This notice may not be removed or altered from any source
           distribution.
        EOS
        expect(template.render("zlib", "John Doe", "2015")).to eq(zlib)
      end
    end

    describe "#find_templates" do
      it "should not return empty array" do
        result = template.send(:find_templates)
        expect(result).not_to be_empty
      end

      it "should return template files" do
        result = template.send(:find_templates)
        result.each do |filename|
          expect(File.extname(filename)).to eq(Licensor::Template::EXTNAME)
        end
      end
    end
  end
end
