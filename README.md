# maxims4sas
This package displays maxims that have deeply impressed me and that I wish to pass on to future generations.  
  
![maxims4sas](./maxims4sas_small.png)  

# %sas_maxims;
 Description     : Displays a collection of "Maxims of Maximally Efficient SAS Programmers" using PROC ODSTEXT with bold styling for emphasis.  
 Author          : Originally compiled by Kurt Bremser (2019)  
                   https://support.sas.com/resources/papers/proceedings19/3062-2019.pdf  
                   And the collective knowledge created by the SAS user community.  
                   https://communities.sas.com/t5/SAS-Communities-Library/Maxims-of-Maximally-Efficient-SAS-Programmers/ta-p/352068  
 Ported by       : Morioka Yutaka  

 Usage Example   :   
 ~~~text
     %sas_maxims;
 ~~~

<img width="723" height="378" alt="Image" src="https://github.com/user-attachments/assets/26a2dde5-450a-40b8-ac81-d6e68b2d515d" />

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
