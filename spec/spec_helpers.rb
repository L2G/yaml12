require 'yaml'

def parsed_yaml(yaml)
   YAML::load(yaml)
end

def each_parsed_yaml(yaml, &block)
   YAML::load_documents(yaml, &block)
end
