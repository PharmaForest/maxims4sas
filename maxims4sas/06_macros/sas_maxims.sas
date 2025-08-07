/*** HELP START ***//*


Macro Name      : `sas_maxims`

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

### Output: 

Stylized text output using `ODSTEXT`, 
intended for inclusion in reports
(PDF, RTF, or HTML via ODS).

### Dependencies: 

Requires ODS destination that supports ODSTEXT (e.g., ODS PDF, ODS RTF, etc.)

---

## Examples:

**Example 1. Print all maxims.**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas 
%sas_maxims()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


**Example 2. Print maxims 1 to 6 and maxims 42 and 52.**
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~sas 
%sas_maxims(1:6, 42, 52)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---


*//*** HELP END ***/

%macro sas_maxims(maxims)/parmbuff minoperator;

%local rc ALL maxim;
%let ALL=0;

%let syspbuff=%qsysfunc(compbl(%qsysfunc(compress(%superq(syspbuff),'"_ ,-:"',kda))));
%if %superq(syspbuff)= %then %let syspbuff=0;

/*%put #%superq(syspbuff)#;*/

%let rc = %sysfunc(dosubl(%str(
options nonotes nostimer nofullstimer nomprint nosymbolgen nomlogic ps=min;
data _null_;
  length maxims $ 256;
  retain maxims " ";

  do i = 1 to 52;
    if i IN (&syspbuff.) then maxims = catx(" ", maxims, i);
  end;

  if maxims NE " " then call symputx("maxims",maxims,"L");
                   else do;
                     call symputx("maxims",0, "L");
                     call symputx("ALL",   1, "L");
                   end;
  _ERROR_=0;
run;
)));

/*%put &=maxims &=all. &=syspbuff.;*/

proc odstext;
h1 "Maxims of Maximally Efficient SAS Programmers" / style=[font_weight=bold]  ;
h2 "Kurt Bremser, 2019"  / style=[fontstyle=italic];

%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 1: Read the Documentation." ;
p "SAS provides extremely well done documentation for its products. Learning to read the documentation will enhance your problem-solving skills by orders of magnitude.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 2: Read the Log." ;
p "Everything you need to know about your program is in the log. Interpreting messages and NOTEs is essential in finding errors.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 3: Know Your Data." ;
p "Having a clear picture of data structures - variable types, lengths, formats - and content will provide you with a fast-path to solving problems.";
p "Many simple problems can be cleared by taking a look at the 'Columns' section in dataset properties. Use proc contents frequently.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 4: If in Doubt, Do a Test Run and Look at the Results. If Puzzled, Inquire Further." ;
p 'SAS is in its core an interpreting language. Running one step is just a few mouse-clicks away. Use that to your advantage."Try it." (Grace Hopper, Admiral, US Navy)';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 5: Ask, and You Will Be Answered." ;
p "SAS Technical Support and the SAS user community stand at the ready to help you. Provide a clear question, example data, your code (with or within the log, see Maxim 2), and where you seem to have failed. Help will be on the way.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 6: Google Is Your Friend." ;
p  'Just entering the text of an error message or problematic issue, prepended with "SAS", will often yield resources with at least a hint for solving your issue on the first result page; the same is true for other search engines.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 7: There Is a Procedure for It." ;
p "(The exception proves the rule)";
p "Learn to use prefabricated procedures for solving your tasks. 5 lines of proc means may equal 20 lines (or more) of data step logic.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 8: There Is a Format for It." ;
p "(The exception proves the rule)";
p "As with Maxim 7, SAS provides a plethora of formats for input and output. Use them to your advantage. If one that fits your needs is not present, rolling your own will usually beat complicated data step logic";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 9: There Is a Function for It." ;
p "(The exception proves the rule)";
p "As of 2019-01-31, documentation.sas.com lists 649 data step functions and call routines. It is almost impossible to not find a function that makes solving an issue easier, or solves it altogether.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 10: SQL May Eat Your WORK and Your Time." ;
p "With large datasets, the way proc sql handles joins will lead to the buildup of large utility files, with lots of random accesses to these. ";
p "This may well prove much less efficient than a join done with a data step and the necessary proc sort steps.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 11: A Macro Is Not Needed." ;
p "(The exception proves the rule)";
p "There may be no need for repeating code when using by-group processing can do the trick. The macro language is also not meant for handling data - like calculating dates - but for creating dynamic code.";
p " Instead of creating lists in macro variables, store them in datasets and use call execute from there. Do calculations in data steps and save the results in macro variables (for later use) with call symput.";
p "A macro cannot solve anything that can't be solved with Base SAS code. But it can reduce the effort needed to write that code, and it can help in making code data-driven. Also see Maxim 33 in reference to call execute.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 12: Make It Look Nice." ;
p "Proper visual formatting makes for better code. Use indentation to make semantic blocks visible. What is on the same logical level, needs to be at the same column.";
p "Avoid overlong lines, make a block of lines if necessary (that 80 character limit of old is not so bad at all).";
p "Be consistent; the next one to maintain that piece of code might be your five-year-older self. Be nice to her.Make frequent use of comments.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 13: When You're Through Learning, You're Through." ;
p "(Will Rogers, John Wooden)";
p "As long as you keep your ability and will to learn, you are alive. When you stop learning, you may not be dead, but you start smelling funny. Never say 'I don't have the time to learn that now'.";
p " The time to learn is NOW. 'Much have I learned from my teachers, more from my colleagues, but most from my students.' - from the Talmud.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 14: Use the Right Tool." ;
p '"How many times do I have to tell you, the right tool for the right job!"(Montgomery Scott, Captain, Starfleet)';
p "Never restrict yourself by a simple 'Use XYZ' or 'Don't use XYZ'. If something is better solved with a certain procedure, use it. If you don't yet know it, learn it (see Maxim 13).";
p ' If a 3rd-party tool is better suited, use it (think of DBMS operations; have them done in the DB itself). Leave operating system tasks to the operating system (see Maxim 15).';
p "";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
h3 "Maxim 15: Know Your Playing Field." ;
p "Make sure to gain knowledge about the environment in which SAS is implemented. Know the system's layout, its basic syntax, and its most important utilities. Especially UNIX is rich with tools that can and will make your life easier. Control the system, don't let the system control you.";
p "";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
h3 "Maxim 16: If It Isn't Written, It Is Not." ;
p 'Anything that is not properly documented, does not exist. It may look like it was there at some time, but the moment you have to deal with undocumented things (programs, data, processes), it is as if you are starting from scratch. ';
p 'The Jedi programmer spends 90% of her time documenting, and reading documentation."I should have written that down. - Dilbert"Scott Adams';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 17: Do It the SAS Way." ;
p "A data warehouse needs different structures than databases, and it needs different structures than spreadsheets. ";
p "Adapt your thinking away from normalized tables (redundancy is avoided in DBMS designs, but is typical in data warehousing tables used for analysis), and also away from cells (spreadsheets have no mandatory attributes for columns, SAS tables have). ";
p "See a SAS table as just the technical entity it is, and model it according to the analytic need.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 18: Separate Your Names." ;
p "Do not use names of predefined SAS functions, call routines or formats for your objects (variables, datasets). This avoids confusion and prevents hard-to-trace errors when a simple typo happens.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 19: Long Beats Wide." ;
p "(Don't keep data in structure)";
p "In the world of spreadsheets, people tend to line up data side-by-side, and put data items (dates, categories, ...) into column headers. ";
p "This runs counter to all the methods available in SAS for group processing, and makes programming difficult, as one has variable column names and has to resort to creating dynamic code ";
p "(with macros and/or call execute) where such is not necessary at all if categories were represented in their own column and data aligned vertically.";
p "There are times where a wide format is needed, eg when preparing data for regression analysis. But for the processing and storing of data, long formats are always to be preferred.Dynamic variable names force unnecessary dynamic code.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 20: Keep Your Names Short." ;
p "Short, concise variable names make for quicker typing with less risk of typos, and make the code more readable. Put additional information in labels, where it belongs.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 21: Formats Beat Joins." ;
p 'Creating a format from a dataset lets you do a "join" on another dataset in one sequential pass. As long as the format fits into memory, it provides an easily understandable means to avoid the sort of a large dataset.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 22: Force Correct Data." ;
p "When reading from external sources, don't rely on proc import. Instead use a data step that will fail with an error if an unexpected event in the input data happens. This lets you detect errors early in your analytic chain. ";
h3 "Maxim 22 specifically precludes using the Excel file format for data interchange, because of the many involved automatisms.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 23: Recursion." ;
p "Recursion.See Maxim 23.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 24: Return With a Zero." ;
p "No batch program can be allowed to end a successful run with a non-zero return code. No WARNINGs, no ERRORs. Any unexpected event shall cause a non-zero return code, so a chain of jobs is halted at the earliest possible moment.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 25: Have a Clean Log." ;
p "The log of a production-level process should be free of any extraneous NOTEs. Automatic type conversions, missing values and so on must not be tolerated.";
p "This allows for easier detection of semantic problems or incorrect data, as these will often cause unexpected NOTEs.";
p 'As long as a part of your log is "unclean", all following ERRORs or other problems might be caused from that, and most of the time are not worthy of your attention. Debug from the top down.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 26: .sas Trumps Catalogs." ;
p "While it is possible to keep code in catalogs, storing it in simple text files is better. SAS catalogs are specific to SAS versions and operating system environments. ";
p "Text files are never version or operating system specific, eventual changes in codepages are handled by SAS itself over the IOM bridge or by file transfer utilities.";
p "Text files also enable you to use external tools for text handling (think grep, awk, sed and so on).In the same vein, always store the code of proc format (and its related cntlin datasets), and do not rely on the created formats in their catalogs. ";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 27: Textuality Rules." ;
p "Use plain text whenever possible. Use simple file formats for data transfer, so you can inspect the data with a text editor. Prefer modern, XML- or JSON-based files (even when compressed, like xlsx) over older, binary formats. ";
p "Store your code in .sas files, use Enterprise Guide projects as temporary containers only while developing. Text lends itself well to versioning and other tools that help the programmer, binary files don't. See Maxim 26.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 28: Macro Variables Need No Formats." ;
p "Keep in mind that '01jan1960'd and 0 represent the same value in SAS code. Therefore you only need formatting of macro variables when they are meant for display (eg in a title statement). ";
p "When you only need them for conditions, the raw values are sufficient and easier to create.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 29: When In Doubt, Use Brute Force." ;
p "(Ken Thompson)";
p 'Use simple, easy-to-understand code. Only revert to "clever" algorithms when circumstances require it. This is also a variant of the KISS (Keep It Simple, Stupid) principle.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 30: Analyze, Then Optimize." ;
p 'Do not engage in optimizing before you know where the bottleneck is, or if there is a bottleneck at all. No need to speed up a step that takes 1 second in real life. Keep your code simple as long as you can (see Maxim 29).';
p '"Premature optimization is the root of all evil"(prob. C. A. R. Hoare)';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 31: Computers Are Dumb." ;
p 'Never trust a piece of software to do on its own what you intend it to do. If you need a certain order, sort or use "order by" in SQL. If a variable should be of certain length, set it. ';
p 'Do not rely on the guessing of proc import, roll your own data step. (see Maxim 22).Even if things work in a certain way on their own now, this does not guarantee anything for the future. ';
p 'New software releases or changes in data might wreck your process. Take control.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 32: No Test Without COMPARE." ;
p "When making a change on an existing piece of code, never release it without running a regression test against data from the previous version with PROC COMPARE. ";
p "This makes sure that only the changes you wanted (or in the case of an optimization, no changes at all) are introduced. ";
p "Even use COMPARE at crucial steps in your development process, so you catch mistakes when they are introduced, instead of having to search for that spot later. If COMPARE takes its time, enjoy your coffee. It's time well spent.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 33: Intelligent Data Makes for Intelligent Programs." ;
p 'The Jedi programmer strives for intelligent data structures. The code will then be intelligent and well-designed (almost) on its own."Bad programmers worry about the code. ';
p "Good programmers worry about data structures and their relationships.(Linus Torvalds)";
p 'When dealing with time-related data, use SAS date and datetime values.Categories are best kept in character variables.Automate the creation of formats (eg from domain-tables in the DB system). ';;
p "Use these formats instead of select() blocks or if-then-else constructs. See Maxim 8.";
p "Create control datasets and use call execute to create code dynamically from them.Keep (especially non-ASCII) literals out of the code (by putting them in data); ";
p "this will avoid problems when code is moved across systems.Use properly structured formats for dates when the sequence matters (YYMMDD instead of MMDDYY).Also see Maxim 19.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 34: Work in Steps." ;
p "Don't solve a task in one everything-including-the-kitchen-sink step. Create intermediate datasets/results, so that each step solves one issue at a time that can easily be comprehended (see Maxim 29). ";
p "In the same vein, don't implement multiple changes to a program in one iteration. Instead do a check-in for every single logical change. ";
p "This allows regression tests for every change, and if something breaks which was not immediately obvious in regression testing, it is easier to step back and find which change introduced the bug.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 35: There's Two Kinds of Stupidity." ;
p "#1 This is old, and therefore it's good"/ style=[font_weight=bold];
p "#2 This is new, and therefore it's better."/ style=[font_weight=bold];
p "Fads have come and gone, but every now and then there's a gem in all the rubble. Be critical, but open-minded.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 36: No Work Is Done Until the Final Test Has Run." ;
p 'The finishing step of every piece of work must include a test of the program in exactly the same environment it will be used (same server, same user, same batch script, etc).';
p ' Only then can you be sure that the first use does not result in a call for support that interrupts your well-earned coffee break. ';
p '"Normal" users may have a more restricted environment than developers, so keep that in mind when developing code for them.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 37: Perfection." ;
p 'Perfection is attained not when there is nothing more to add, but when there is nothing more to remove.(Antoine de Saint-Exupery) Another application of the KISS principle; also think of the practice of "muntzing" applied to programming.';
p 'Get rid of unnecessary code, redundant variables, irrelevant observations."Perfection is not attainable, but if we chase perfection we can catch excellence."(Vince Lombardi)';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 38: Beware of the Dread God Finagle." ;
p 'And heed the words of his mad prophet Murphy:"What can go wrong, will go wrong".Write your code in this light, and include safeguards in expectation of the unexpected.Make sure that you are notified when the unexpected happens ';
p '(eg make a batch program crash on invalid data, so the scheduler catches it).(With regards to Larry Niven.)';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 39: Be Human." ;
p "Everybody makes mistakes, including you. Be kind when dealing out critique, as someone might be forced to critique you 5 minutes later.There's always a better, and a worse. You're not the worst, but surely you're not the best. ";
p "Learn from both, and be kind to both.And remember that the code is not the coder. Very nice people can write incredibly ugly code, and vice versa.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 40: Talk to the Customer." ;
p "Having a good line of communication with the ultimate consumer of data is essential.Make them formulate their needs in clear, unambiguous language; often this act of questioning themselves provides a major advance in solving the problem.";
p "Never solve a problem that you think the customer needs solved.Deliver example results early and often.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 41: Wisdom Emerges from Experience." ;
p "Unfortunately, most experience emerges from stupidity.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 42: It's Not the Answer, It's the Question." ;
p 'A well-formulated question may already lead you in the right direction before you speak it out loud or write it down.An ill-formulated question will get you the equivalent of "42".';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 43: Keep the Final Goal in Mind." ;
p 'Which information needs to end up where? The answer to this question shall guide your selection of tools and methods, not the other way round.' ;
p 'Information is at the core of your work, and delivering it correctly, timely, and usable is your ultimate goal.Once the content is delivered and accepted, you can think of "prettying up".';
p 'All this implies that the requirements have been refined and clearly worded (see Maxim 42). Have test cases defined against which you can prove your code.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 44: Leave No Spaces." ;
p "All operating systems and programming languages use blank space as the prime separator of names and objects. It is therefore a VERY BAD idea to have spaces in names (of files, directories, columns and so on).";
p "Even when a certain environment provides a means to do so (encapsulating file names in quotes in UNIX and Windows, or the 'my name'n construct in SAS), one should not use that. ";
p "Underlines can convey the same meaning and make handling of such names easier by orders of magnitude.";
p "(The fact that certain products make happy use of blanks in file- and pathnames does not make this practice right; it just illustrates the incompetence accumulated in some places.)";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 45: TANSTAAFL." ;
p "There Ain't No Such Thing As A Free Lunch.";
p "A big salute to the great Robert A. Heinlein for this perennial truth.Good, durable code requires thought and hard work. Be prepared to provide both.'";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 46: Beware of the Hidden Blanks." ;
p "One tends to forget the fact that character variables have a fixed defined length, and values will always be padded with blanks up to that length. So it is always a good idea to use trim() when doing comparisons or concatenations.";
p "Example:";
p "if charvar in ('AAA','BBB','CCC');" / style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "will work even if the defined length of charvar is > 3, but";
p "if findw('AAA BBB CCC',charvar) > 0;"/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "will fail if charvar has a length of 5 and will therefore contain 'AAA ', which can't be found in the comparison string.Similarly, charvar = charvar !! 'some_other_string'; will invariably surprise the unwary novice.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 47: Set a Length." ;
p "When creating new character variables, always set a sufficient length explicitly. When character variables are assigned literals, the first such assignment sets the length, causing confusion afterwards, because longer data will be truncated.";
p "Example:";
p "flag = 'no';"/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "if (condition) then flag = 'yes';"/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "if flag = 'yes' then ..."/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "Surprise!";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 48: The Dot, the Dot, Always the Dot." ;
p "Make it a habit to always terminate macro variable references with a dot. It's never wrong to have the dot, but omitting it can have consequences and cause confusion.";
p "See";
p 'libname myexcel xlsx "/path/excelfile&year.xlsx";' / style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 49: Don't Forget to run;" ;
p "People frequently omit the run; statement, because SAS takes care of step boundaries all by itself.But there are circumstances when this can cause a hard-to-detect problem; imagine this part of a macro:";
p "data _null_;"/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "call symputx('nobs',nobs);"/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p "set have nobs=nobs;"/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p '%do i = 1 %to &nobs;'/ style=[font=("<Courier New>,Courier,sasmono") color=blue font_size=2];
p 'Since no run; was encountered, the data step was not yet compiled and executed, leading to a "symbolic reference not resolved" error.';
p 'Bottom line: as with dots in macro variable references, the run; never hurts, but its absence sometimes does.';
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 50: Check Your OBS= System Option." ;
p "Often OBS= was set to limit the number of observations for tests. This will cause seemingly inexplicable terminations of steps later on.";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 51: Hash Can Fire You Up." ;
p "The rather recently (version 9) introduced hash object provides a high-performance tool for in-memory lookups that helps solve complicated issues which required complex programming earlier on, or ";
p "multi-step operations consuming time and disk space.Learning its basic operation, and use in advanced situations is a must for the aspiring SAS programmer.A very good introduction is found in SAS(R) Hash Object Programming Made Easy by Michele M. Burlew";
%end;
%let maxim=%eval(&maxim. +1);
%if &maxim. in (&maxims.) or &ALL. %then %do;
p "";
h3 "Maxim 52: Take a Break." ;
p "Whenever you run into a seemingly unsolvable problem, turn away from it for a while. Play a game (or watch one), listen to music, have a conversation with your S.O., make up a good meal, or just have a good coffee. ";
p "Or have a night's sleep.Cleansing your mind from all the (non-helping) thoughts you already had will open it up for the single new one you need to get over the obstacle.It may even be the case that a solution comes to you in your dreams ";
p "(I had that happen to me once; got up in the middle of the night, took some notes, and solved the issue in just a few minutes after arriving back at the office).";
%end;

p "";
p "";
h3 "References:";
p '"Maxims of Maximally Efficient SAS Programmers"' / style=[font_weight=bold];
p "https://support.sas.com/resources/papers/proceedings19/3062-2019.pdf" / style=[font=("<Courier New>,Courier,sasmono") font_size=2];
p "";
p "SAS Communities Library Maxims of Maximally Efficient SAS Programmers" / style=[font_weight=bold] ;
p "https://communities.sas.com/t5/SAS-Communities-Library/Maxims-of-Maximally-Efficient-SAS-Programmers/ta-p/352068" / style=[font=("<Courier New>,Courier,sasmono") font_size=2];
p "";

run;
quit;

%mend sas_maxims;


/* Maxims of Maximally Efficient SAS Programmers */
