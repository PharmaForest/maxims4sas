/* Adapted from maxims4sas/01_macros/sas_maxims.sas (the %sas_maxims macro),
   lines 69-83 of the repo's own data _null_ step -- the selector-parsing logic
   that %sysfunc(dosubl(...)) normally runs inside the macro. This bundle
   exercises the "print every maxim" default path: an empty selector list
   (the macro's own normalization, `%if %superq(syspbuff)= %then %let
   syspbuff=0;`, maps a no-argument call like %sas_maxims() to the literal
   selector "0"), which takes the ELSE branch of the repo's own IF and sets
   ALL=1 -- the branch not exercised by the ranged-selector bundle
   (t001_maxim_selector).

   DOSUBL is not implemented in Jenner (an accepted, intentionally-stubbed
   gap, not a bug), so &syspbuff. is pre-resolved here to the value the
   macro's own preprocessing would produce for %sas_maxims(). The data step
   below -- the part that actually implements the selection algorithm -- is
   unmodified from the repo. */

%let syspbuff = 0;

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

%put NOTE: selected maxims = &maxims. print_all=&ALL.;
