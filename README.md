# Color decomposition

<img align="left" hspace="6" src="http://i.imgur.com/7L6XkjE.gif" width="120">

A quadtree color decomposition algorithm that uses the CIELAB color space and the
CIEDE2000 color-difference formula.

The generated quadtree structure contains the leaves that represent the highest node
levels containing a perceptually similar color for a given area.

<br>

## Prerequisite

This gem requires an installation of
[ImageMagick](https://legacy.imagemagick.org/script/download.php) `version 6`.

## Installation

Installing can be done by adding the following line to an application's Gemfile:

``` ruby
gem 'color_decomposition'
``` 

and then executing:

``` bash
$ bundle
``` 

Or just install it yourself using:

``` bash
$ gem install color_decomposition
``` 

## Usage

Generating the actual quadtree simply requires calling the `quadtree` method. This
method takes 2 parameters. The first being the path to the image and the second being
the color similarity level that the CIEDE2000 formula should use. The larger this value,
the more color loss will be permitted. A larger value will therefore allow the creation 
of larger leaf nodes at the cost of color accuracy.

When comparing 2 colors, a CIEDE2000 value of `<= 1` will generally mean that the
difference between them will not be perceivable to the human eye.

``` ruby
require 'color_decomposition'

quadtree = ColorDecomposition.quadtree('ruby.png', 1)
```

This will return a [Node](https://github.com/jonasbleyl/color-decomposition/blob/master/lib/color_decomposition/quadtree/node.rb) object containing the following accessible instance variables: `rgb`, `lab`, `rect` and `child_nodes`. However, only the leaf
nodes will have the RGB and CIELAB color values set.

The color conversions and CIEDE2000 calculation can also be used on their own.

``` ruby
require 'color_decomposition'

include ColorDecomposition

color1 = Color.new(r: 255, g: 120, b: 60)
puts color1.xyz # {:x=>48.77208180663368, :y=>35.01918603060906, :z=>8.46377233268254}
puts color1.lab # {:l=>65.76360001472788, :a=>47.86642591164642, :b=>55.61626679147632}

color2 = Color.new(r: 80, g: 49, b: 220)
puts Comparator.ciede2000(color1.lab, color2.lab) # 57.24131929494836
```


## Resources

* [Color space conversions paper.](http://sites.biology.duke.edu/johnsenlab/pdfs/tech/colorconversion.pdf)
* [sRGB to CIEXYZ transformation values and D65 standard.](http://web.archive.org/web/20110722134652/http://www.colour.org/tc8-05/Docs/colorspace/61966-2-1.pdf)
* [CIEDE2000 color-difference formula paper and test data.](http://www.ece.rochester.edu/~gsharma/ciede2000)
