#!/bin/bash

dest="${PWD}/listings/chapterFive/QRmethod.m"
if [ ! -f "$dest" ] 
then 
  src="${PWD}/listings/chapterThree/QRmethod.m"
  ln -s "$src" "$dest"
fi

dest="${PWD}/listings/chapterFive/triangularSystemSolver.m"
if [ ! -f "$dest" ] 
then 
  src="${PWD}/listings/chapterThree/triangularSystemSolver.m"
  ln -s "$src" "$dest"
fi

# add another if block for the link associated in the other computer
