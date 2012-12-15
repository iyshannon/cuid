# cuid.rb - CUID ported to Ruby
Last updated: December 15, 2012
[![Build Status](https://travis-ci.org/iyshannon/cuid.png)](https://travis-ci.org/iyshannon/cuid)
Documentation: [http://iyshannon.github.com/cuid](http://iyshannon.github.com/cuid)

## Introduction

cuid.rb is a ruby library that provides collision-resistant ids optimized for horizontal scaling and sequential lookup performance.

This is just going to cover the basics and the Ruby-specific implementation details.

**Please refer to the [main project site](http://usecuid.org) for the full story.**

## Example

ch72gsb320000udocl363eofy

### Broken down

** c - h72gsb32 - 0000 - udoc - l363eofy **

The groups, in order, are:

* 'c' - identifies this as a cuid, and allows you to use it in html entity ids. The fixed value helps keep the ids sequential.
* Timestamp
* Counter - a single process might generate the same random string. The weaker the pseudo-random source, the higher the probability. That problem gets worse as processors get faster. The counter will roll over if the value gets too big.
* Client fingerprint
    * In Ruby, the first two characters are based on the process ID and the next two characters are based on the hostname.  This is the same method used in the Node implementation.
* Pseudo random number
    * By default, Ruby uses the `Kernel#rand` function, a Mersenne Twister PRNG.
    * On Ruby 1.9.2 and up, it can optionally use the `SecureRandom` library (which uses OpenSSL), but there is a significant performance cost.

## System Requirements

This gem was developed under `ruby1.9.3-p286` but is tested under multiple versions thanks to [Travis CI](http://www.travis-ci.org).

Tested under:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* JRuby 1.9 (jruby19mode)

## Installation

    gem install cuid

## Example Usage

    irb(main):001:0> require "cuid" 
    => true
    irb(main):002:0> g = Cuid::generate
    => "ch8qypsnz0000a4welw8anyra"
    irb(main):003:0> Cuid::validate(g)
    => true
    irb(main):004:0> Cuid::generate(4)
    => ["ch8qyq35f0002a4wekjcwmh30", "ch8qyq35f0003a4weewy22izq", "ch8qyq35f0004a4webzzelvdv", "ch8qyq35f0005a4wesg3tfjk5"]    

## Credit

* Ian Shannon [(ported to Ruby)](http://github.com/iyshannon/cuid)
* Eric Elliott [(original JavaScript version)](http://github.com/dilvie/cuid)

## MIT Open Source License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
