require 'spec_helpers'

describe 'YAML 1.2 reference implementation' do
   context 'Sec. 2.1 Collections' do
      example 'Example 2.1 "Sequence of Scalars (ball players)" parses correctly' do
         yaml_text =
<<_YAML_
- Mark McGwire
- Sammy Sosa
- Ken Griffey
_YAML_
         object = ['Mark McGwire', 'Sammy Sosa', 'Ken Griffey']
         parsed_yaml(yaml_text).should == object
      end

      example 'Example 2.2 "Mapping Scalars to Scalars (player statistics)" parses ' +
      'correctly' do
         yaml_text =
<<_YAML_
hr:  65    # Home runs
avg: 0.278 # Batting average
rbi: 147   # Runs Batted In
_YAML_
         object = {
            'hr' => 65,
            'avg' => 0.278,
            'rbi' => 147
         }
         parsed_yaml(yaml_text).should == object
      end

      example 'Example 2.3 "Mapping Scalars to Sequences (ball clubs in each league)" ' +
      'parses correctly' do
         yaml_text =
<<_YAML_
american:
  - Boston Red Sox
  - Detroit Tigers
  - New York Yankees
national:
  - New York Mets
  - Chicago Cubs
  - Atlanta Braves
_YAML_
         object = {
            'american' => ['Boston Red Sox', 'Detroit Tigers', 'New York Yankees'],
            'national' => ['New York Mets', 'Chicago Cubs', 'Atlanta Braves']
         }
         parsed_yaml(yaml_text).should == object
      end

      example 'Example 2.4 "Sequence of Mappings (players\' statistics)" parses ' +
      'correctly' do
         yaml_text =
<<_YAML_
-
  name: Mark McGwire
  hr:   65
  avg:  0.278
-
  name: Sammy Sosa
  hr:   63
  avg:  0.288
_YAML_
         object = [
            { 'name' => 'Mark McGwire',
              'hr' => 65,
              'avg' => 0.278 },
            { 'name' => 'Sammy Sosa',
              'hr' => 63,
              'avg' => 0.288 }
         ]
         parsed_yaml(yaml_text).should == object
      end

      example 'Example 2.5 "Sequence of Sequences" parses correctly' do
         yaml_text =
<<_YAML_
- [name        , hr, avg  ]
- [Mark McGwire, 65, 0.278]
- [Sammy Sosa  , 63, 0.288]
_YAML_
         object = [
            ['name', 'hr', 'avg'],
            ['Mark McGwire', 65, 0.278],
            ['Sammy Sosa', 63, 0.288]
         ]
         parsed_yaml(yaml_text).should == object
      end

      example 'Example 2.6 "Mapping of Mappings" parses correctly' do
         yaml_text =
<<_YAML_
Mark McGwire: {hr: 65, avg: 0.278}
Sammy Sosa: {
    hr: 63,
    avg: 0.288
  }
_YAML_
         object = {
            'Mark McGwire' => {'hr' => 65, 'avg' => 0.278},
            'Sammy Sosa' => {'hr' => 63, 'avg' => 0.288}
         }
         parsed_yaml(yaml_text).should == object
      end
   end

   context 'Sec. 2.2 Structures' do
      example 'Example 2.7 "Two Documents in a Stream (each with a leading comment)" parses correctly' do
         yaml_text =
<<_YAML_
# Ranking of 1998 home runs
---
- Mark McGwire
- Sammy Sosa
- Ken Griffey

# Team ranking
---
- Chicago Cubs
- St Louis Cardinals
_YAML_
         object1 = ['Mark McGwire', 'Sammy Sosa', 'Ken Griffey']
         object2 = ['Chicago Cubs', 'St Louis Cardinals']
         parsed = []
         each_parsed_yaml(yaml_text) {|p| parsed << p}
         parsed[0].should == object1
         parsed[1].should == object2
      end

      example 'Example 2.8 "Play by Play Feed from a Game" parses correctly' do
         yaml_text =
<<_YAML_
---
time: 20:03:20
player: Sammy Sosa
action: strike (miss)
...
---
time: 20:03:47
player: Sammy Sosa
action: grand slam
...
_YAML_
         object1 = {'time' => '20:03:20',
                    'player' => 'Sammy Sosa',
                    'action' => 'strike (miss)'}
         object2 = {'time' => '20:03:47',
                    'player' => 'Sammy Sosa',
                    'action' => 'grand slam'}

         parsed = []
         each_parsed_yaml(yaml_text) {|p| parsed << p}
         parsed[0].should == object1
         parsed[1].should == object2
      end

      example 'Example 2.9 "Single Document with Two Comments" parses correctly'
      example 'Example 2.10 "Node for \'Sammy Sosa\' appears twice in this document" parses correctly'
      example 'Example 2.11 "Mapping between Sequences" parses correctly'
      example 'Example 2.12 "Compact Nested Mapping" parses correctly'
   end

   context "Sec. 2.3 Scalars" do
      example 'Example 2.13 "In literals, newlines are preserved" parses correctly'
      example 'Example 2.14 "In the folded scalars, newlines become spaces" parses correctly'
      example 'Example 2.15 "Folded newlines are preserved for \'more indented\' and blank lines" parses correctly'
      example 'Example 2.16 "Indentation determines scope" parses correctly'
      example 'Example 2.17 "Quoted Scalars" parses correctly'
      example 'Example 2.18 "Multi-line Flow Scalars" parses correctly'
   end

   context "Sec. 2.4 Tags" do
      example 'Example 2.19 "Integers" parses correctly'
      example 'Example 2.20 "Floating Point" parses correctly'
      example 'Example 2.21 "Miscellaneous" parses correctly'
      example 'Example 2.22 "Timestamps" parses correctly'
      example 'Example 2.23 "Various Explicit Tags" parses correctly'
      example 'Example 2.24 "Global Tags" parses correctly'
      example 'Example 2.25 "Unordered Sets" parses correctly'
      example 'Example 2.26 "Ordered Mappings" parses correctly'
   end

   context "Sec. 2.5 Full Length Example" do
      example 'Example 2.27 "Invoice" parses correctly'
      example 'Example 2.28 "Log File" parses correctly'
   end
end
# vim:ft=ruby:ai:tw=0:
