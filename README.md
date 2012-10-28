cuid.rb - CUID ported to Ruby
=====================
Release date: October 26, 2012

Authors
=======
* Ian Shannon (port to Ruby)
* Eric Elliott (original JavaScript version)

Introduction
============
cuid.rb is a ruby library that provides `collision-resistant ids optimized for horizontal scaling and sequential lookup performance`
Please refer to the [original author's repository](http://github.com/dilvie/cuid) for an indepth README.

Example
=======
ch72gsb320000udocl363eofy

System Requirements
===================
Tested under ruby 1.............

Installation
============

    gem install cuid

Example Usage
=============

    irb(main):001:0> require "cuid" 
    => true
    irb(main):002:0> g = Cuid::generate
    => "ch8qypsnz0000a4welw8anyra"
    irb(main):003:0> Cuid::validate(g)
    => true
    irb(main):004:0> Cuid::generate(4)
    => ["ch8qyq35f0002a4wekjcwmh30", "ch8qyq35f0003a4weewy22izq", "ch8qyq35f0004a4webzzelvdv", "ch8qyq35f0005a4wesg3tfjk5"]    

MIT Open Source License
=======================
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
