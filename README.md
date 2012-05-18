# bio-phyloxml

[![Build Status](https://secure.travis-ci.org/csw/bioruby-phyloxml.png)](http://travis-ci.org/csw/bioruby-phyloxml)

bio-phyloxml is a [phyloXML](http://www.phyloxml.org/) plugin for
[BioRuby](http://bioruby.open-bio.org/), an open source bioinformatics
library for Ruby.

phyloXML is an XML language for saving, analyzing and exchanging data
of annotated phylogenetic trees. The phyloXML parser in BioRuby is
implemented in Bio::PhyloXML::Parser, and its writer in
Bio::PhyloXML::Writer.  More information can be found at
[phyloxml.org](http://www.phyloxml.org).

This phyloXML code has historically been part of the core BioRuby
[gem](https://github.com/bioruby/bioruby), but has been split into its
own gem as part of an effort to
[modularize](http://bioruby.open-bio.org/wiki/Plugins)
BioRuby. bio-phyloxml and many more plugins are available at
[biogems.info](http://www.biogems.info/).

This code was originally written by Diana Jaunzeikare during the
Google Summer of Code 2009 for the
[Implementing phyloXML support in BioRuby](http://informatics.nescent.org/wiki/Phyloinformatics_Summer_of_Code_2009#Implementing_phyloXML_support_in_BioRuby)
project with NESCent, mentored by Christian Zmasek et al. For details
of development, see
[github.com/latvianlinuxgirl/bioruby](https://github.com/latvianlinuxgirl/bioruby)
and the BioRuby mailing list archives.

*NOTE:* this is currently in the repackaging process and is not yet
 released! Production users should use the phyloXML support provided
 with BioRuby for the time being.

## Requirements

bio-phyloxml uses [libxml-ruby](http://xml4r.github.com/libxml-ruby/),
which requires several C libraries and their headers to be installed:
 * `zlib`
 * `libiconv`
 * `libxml`
 
With these installed, the `bio` and `libxml-ruby` gems should be installed

```sh
gem install -r bio libxml-ruby
```

For more information see the
[libxml installer page](http://libxml.rubyforge.org/install.xml) and
the [BioRuby] installation page](http://bioruby.open-bio.org/wiki/Installation).


## Installation

```sh
gem install bio-phyloxml
```

## Migration

Users who were previously using the phyloXML support in the core
BioRuby gem should be able to migrate to using this gem very
easily. Simply install the `bio-phyloxml` gem as described below, and
add `require 'bio-phyloxml'` to the relevant application code.

## Usage

```ruby
require 'bio-phyloxml'
```

### Parsing a file

```ruby
require 'bio-phyloxml'

# Create new phyloxml parser
phyloxml = Bio::PhyloXML::Parser.open('example.xml')

# Print the names of all trees in the file
phyloxml.each do |tree|
  puts tree.name
end
```

If there are several trees in the file, you can access the one you wish by specifying its index:

```ruby
tree = phyloxml[3]
```
You can use all Bio::Tree methods on the tree, since PhyloXML::Tree inherits from Bio::Tree. For example, 

```ruby
tree.leaves.each do |node|
 puts node.name
end
```

PhyloXML files can hold additional information besides phylogenies at the end of the file. This info can be accessed through the 'other' array of the parser object.

```ruby
phyloxml = Bio::PhyloXML::Parser.open('example.xml')
while tree = phyloxml.next_tree
  # do stuff with trees
end 

puts phyloxml.other
```

### Writing a file

```ruby
# Create new phyloxml writer
writer = Bio::PhyloXML::Writer.new('tree.xml')

# Write tree to the file tree.xml
writer.write(tree1) 

# Add another tree to the file
writer.write(tree2)
```

### Retrieving data

Here is an example of how to retrieve the scientific name of the clades included in each tree.

```ruby
require 'bio-phyloxml'

phyloxml = Bio::PhyloXML::Parser.open('ncbi_taxonomy_mollusca.xml')
phyloxml.each do |tree|
  tree.each_node do |node|
    print "Scientific name: ", node.taxonomies[0].scientific_name, "\n"
  end
end
```

### Retrieving 'other' data

```ruby
require 'bio'

phyloxml = Bio::PhyloXML::Parser.open('phyloxml_examples.xml')
while tree = phyloxml.next_tree
 #do something with the trees
end

p phyloxml.other
puts "\n"
#=> output is an object representation

#Print in a readable way
puts phyloxml.other[0].to_xml, "\n"
#=>:
#
#<align:alignment xmlns:align="http://example.org/align">
#  <seq name="A">acgtcgcggcccgtggaagtcctctcct</seq>
#  <seq name="B">aggtcgcggcctgtggaagtcctctcct</seq>
#  <seq name="C">taaatcgc--cccgtgg-agtccc-cct</seq>
#</align:alignment>

#Once we know whats there, lets output just sequences
phyloxml.other[0].children.each do |node|
 puts node.value
end
#=>
#
#acgtcgcggcccgtggaagtcctctcct
#aggtcgcggcctgtggaagtcctctcct
#taaatcgc--cccgtgg-agtccc-cct
```

The API doc is online. (TODO: generate and link) For more code
examples see the test files in the source tree.

## Project home page

Information on the source tree, documentation, examples, issues and
how to contribute, see

  http://github.com/csw/bioruby-phyloxml

The BioRuby community is on IRC server: irc.freenode.org, channel: #bioruby.

## Cite

If you use this software, please cite one of
  
* [BioRuby: bioinformatics software for the Ruby programming language](http://dx.doi.org/10.1093/bioinformatics/btq475)
* [Biogem: an effective tool-based approach for scaling up open source software development in bioinformatics](http://dx.doi.org/10.1093/bioinformatics/bts080)

## Biogems.info

This Biogem is published at [#bio-phyloxml](http://biogems.info/index.html)

## Copyright

Copyright (c) 2009 Diana Jaunzeikare. See LICENSE.txt for further details.

