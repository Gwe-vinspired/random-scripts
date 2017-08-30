# For Ray, going through all the vapi models and getting a list of models 
# related (through foreign keys or join tables)

# Run through a rails console:
#   $: cd ~/vinspired/vapi
#   $: rails c
#   pry> load '../script/view_relationships.rb'
#   pry> find_all_models

# Output:
#   + writes to a csv file: ~/vinspired/vapi/model_relations.csv

require "csv"

def find_all_models
  # iterate over all files in folder
  folder = File.join('.', "app", "models")      
  Dir[File.join(folder, "*")].each do |filename|
    # remove .rb
    model_name = File.basename(filename).sub(/.rb$/, '').camelize
    model = Kernel.const_get(model_name)
    CSV.open("model_relations.csv", "a") do |csv|
      # csv << ["#{model_name}","#{model}"]
      begin
        assos = model.reflect_on_all_associations
        # p "#{model_name} , #{model}"
        csv << ["#{model_name}","#{model.inspect}"]
        assos.each do |a|
          csv << ["#{a.name}"]
        end  
        csv << ["----","------------------------------------"]
      rescue
      end 
    end 
  end
end
