#!/bin/bash

dest="${PWD}/listings/chapterFour/normalizationEngine.m"
if [ ! -f "$dest" ] 
then 
  src="${PWD}/listings/chapterThree/normalizationEngine.m"
  ln -s "$src" "$dest"
fi

dest="${PWD}/listings/chapterFour/PALUmethod.m"
if [ ! -f "$dest" ] 
then 
  src="${PWD}/listings/chapterThree/PALUmethod.m"
  ln -s "$src" "$dest"
fi

dest="${PWD}/listings/chapterFour/QRmethod.m"
if [ ! -f "$dest" ] 
then 
  src="${PWD}/listings/chapterThree/QRmethod.m"
  ln -s "$src" "$dest"
fi

dest="${PWD}/listings/chapterFour/triangularSystemSolver.m"
if [ ! -f "$dest" ] 
then 
  src="${PWD}/listings/chapterThree/triangularSystemSolver.m"
  ln -s "$src" "$dest"
fi

# add another if block for the link associated in the other computer
