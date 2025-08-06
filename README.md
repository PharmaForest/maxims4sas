# maxims4sas
This package displays maxims that have deeply impressed me and that I wish to pass on to future generations.  
  
![maxims4sas](./maxims4sas_small.png)  

# %sas_maxims;
## Description:
This macro presents 50+ practical and philosophical principles aimed at  
improving SAS programming habits. It can be used in training materials,  
documentation, or as motivational content.  
 
Call to the macro displays a collection of   
"*Maxims of Maximally Efficient SAS Programmers*"  
using `PROC ODSTEXT` with bold styling for emphasis.  
  
### Author:  
Originally compiled by **Kurt Bremser** (2019)  
[Maxims of Maximally Efficient SAS Programmers](https://support.sas.com/resources/papers/proceedings19/3062-2019.pdf)  

Ported by: Morioka Yutaka  
Major updates and improvements by: Bartosz Jablonski  

### Parameters: 
- `maxims` - *OPTIONAL*, list of numbers of maxims to be printed. 
              When empty *all* are printed. See examples.

## Examples:

**Example 1. Print all maxims.**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas 
%sas_maxims()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


**Example 2. Print maxims 1 to 6 and maxims 42 and 52.**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas 
%sas_maxims(1:6, 42, 52)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


# version history<br>
0.1.0(06August2025): Initial version<br>

## What is SAS Packages?  
The package is built on top of **SAS Packages framework(SPF)** developed by Bartosz Jablonski.<br>
For more information about SAS Packages framework, see [SAS_PACKAGES](https://github.com/yabwon/SAS_PACKAGES).  
You can also find more SAS Packages(SASPACs) in [SASPAC](https://github.com/SASPAC).

## How to use SAS Packages? (quick start)
### 1. Set-up SPF(SAS Packages Framework)
Firstly, create directory for your packages and assign a fileref to it.
~~~sas      
filename packages "\path\to\your\packages";
~~~
Secondly, enable the SAS Packages Framework.  
(If you don't have SAS Packages Framework installed, follow the instruction in [SPF documentation](https://github.com/yabwon/SAS_PACKAGES/tree/main/SPF/Documentation) to install SAS Packages Framework.)  
~~~sas      
%include packages(SPFinit.sas)
~~~  
### 2. Install SAS package  
Install SAS package you want to use using %installPackage() in SPFinit.sas.
~~~sas      
%installPackage(packagename, sourcePath=\github\path\for\packagename)
~~~
(e.g. %installPackage(ABC, sourcePath=https://github.com/XXXXX/ABC/raw/main/))  
### 3. Load SAS package  
Load SAS package you want to use using %loadPackage() in SPFinit.sas.
~~~sas      
%loadPackage(packagename)
~~~
### Enjoy😁
