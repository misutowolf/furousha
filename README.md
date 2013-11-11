# Furousha

A Vagrant setup for Rails development!

### Table of Contents

1.  What is Furousha?
2.  Prerequisites
3.  Starting It Up
4.  Creating a Project
5.  Guard::LiveReload Usage

### 1.  What is Furousha?

When I started working with Ruby/Rails, it dawned on me that despite the fact I wanted to work in Windows (I'm also a gamer), it was a poor
OS choice for the language.  I thought about various solutions, including dual-booting...but decided that a VM was the best way to deal
with things...enter Vagrant.

I was told about Vagrant by a good friend of mine (Craig McKechnie).  Vagrant is a system used for deploying customisable Virtual Machine
environments, which can be based on numerous Boxes, and provisioned in various ways (Puppet, Chef, Shellscripts).

This project is such a setup, aimed at Windows users who want to develop Rails apps in a better (read: Linux) environment, allowing
them to use their favorite IDE of choice, while running their development app in an environment more suited to doing so.

Furousha includes the following:

* Ubuntu 12.04 LTS (Precise Pangolin) (x86)
* Ubuntu Packages:
  * libxml2
  * nodejs
  * screen
  * vim
* RVM - Ruby Version Manager
* Ruby 2.0.0-p247 (x86) - Set as system default
* Ruby Gems:
  * **puppet** - Provisioning system for Vagrant, etc.
  * **rails** - MVC-based web framework for Ruby
  * **rspec-rails** - Testing framework for Ruby/Rails
  * **capybara** - Integration testing for RSpec/Rails
  * **haml** - Alternate templating language
  * **guard-livereload** - LiveReload, for Rails development
  * **devise** - Rails authentication system
  * **mailcatcher** - Mock SMTP setup for things like Devise registration

### 2.  Prereqisites

In order to get started with Furousha/Vagrant, you must have the following installed:

* [VirtualBox](http://virtualbox.org) -- Vagrant's VMs are by default based on VirtualBox, as it works via VBoxManage.
* [Vagrant](http://vagrantup.com) itself.
* LiveReload plugin for your browser (if you plan to use Guard::LiveReload)
  * Safari -- ([link](http://download.livereload.com/2.0.9/LiveReload-2.0.9.safariextz))
  * Chrome -- ([link](https://chrome.google.com/webstore/detail/livereload/jnihajbhpnppcggbcgedagnkighmdlei))
  * Firefox -- ([link](http://download.livereload.com/2.0.8/LiveReload-2.0.8.xpi))

Download links are at the end of this documentation.

### 3.  Starting up your environment.

Getting started with Furousha is pretty easy.  First, clone this repository into a folder of your choosing:

    git clone https://github.com/misutowolf/furousa.git <project name>

Then, just jump to your project folder and fire up your VM:

    cd <project name>
    vagrant up

Vagrant should then grab the base box (if you don't have it already), and then provision it (using Puppet).

### 4.  Starting a project

In order to get started with a Rails project, you'll need to SSH into your Vagrant box and generate one using Rails:

    vagrant ssh
    cd /vagrant/
    rails new <project>

This will create a new Rails project in the default Vagrant synced folder, <code>/vagrant/</code>.  This will allow you
to edit your project files using any editor you want, whether it be oustide the VM (in Windows), or inside (vim/nano/etc.)

### 5.  Guard::LiveReload

The gem for LiveReload comes pre-installed with this setup.  However, due to a bug with Guard, invoking Guard with your
Rails project in typical fashion doesn't work.  When it comes to using LiveReload within Furousha, first add it to your
project's Gemfile:

    group :development do
      gem 'guard-livereload'
    end

Then make sure it's installed in your project:

    bundle install

After you've got the gem in your project, you must force polling when running Guard, after adding proper lines to your Guardfile:

    bundle exec guard init livereload
    bundle exec guard --force-polling

Port forwarding is already enabled for LiveReload's default port, so no additional steps should not be required.