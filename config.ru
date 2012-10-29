#!/usr/bin/env rackup

$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'gruff_server'

root = File.expand_path(File.dirname(__FILE__))
run GruffServer.server(root, {extension: 'jpg'})

