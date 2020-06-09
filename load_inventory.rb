#!/usr/bin/env ruby
# frozen_string_literal: true

require './lib/imports/import'

file_path = ARGV.first
Imports::Import.import(file_path)
