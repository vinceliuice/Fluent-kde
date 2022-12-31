#!/bin/bash


for theme in '' '-purple' '-pink' '-red' '-orange' '-yellow' '-green' '-grey' '-teal'; do

  defaults_file="com.github.vinceliuice.Fluent-round${theme}-light/contents/defaults"
  sed -i "s/Fluent${theme}-cursors/Fluent-cursors/g" ${defaults_file}

done


