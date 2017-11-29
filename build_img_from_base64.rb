require 'base64'

def upload(data)
  file = File.new('image.png', "wb")
  decoded_string = Base64.decode64(data)
  File.open('image.png', 'wb') { |file| file << decoded_string }
end

require 'base64'

def decode(data)
  string = File.open(data, "rb").read
  p string
  decoded_string = Base64.decode64(string)
  p decoded_string
  file = File.open('image.png', 'wb') { |file| file << decoded_string }

  # file = File.new('image.png', "wb")
  # file.write Base64.decode64(data)
end


def encode(image)
  file = File.new('encoded.txt', "wb")
  file.write Base64.encode64(open(image).to_a.join)
end


# return nil unless base64_data.present?
#     byebug
#     @_temporary_file_paths ||= []
#     tempfile_path = File.join(Rails.root, "tmp", filename)
#     @_temporary_file_paths << tempfile_path

#     file = File.new(tempfile_path, "wb")
#     file.write Base64.decode64(base64_data)

#     file