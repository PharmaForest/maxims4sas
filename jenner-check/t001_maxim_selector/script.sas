/* Adapted from maxims4sas/01_macros/sas_maxims.sas (the %sas_maxims macro),
   lines 69-83 of the repo's own data _null_ step -- the selector-parsing logic
   that %sysfunc(dosubl(...)) normally runs inside the macro to turn a
   maxim-number list like "1:6, 42, 52" into the flat list of maxims to print.

   DOSUBL is not implemented in Jenner (it is intentionally stubbed, an
   accepted gap -- not a bug), so this bundle exercises the data step directly
   with &syspbuff. pre-resolved to the value the macro's own preprocessing
   (%qsysfunc(compbl(%qsysfunc(compress(%superq(syspbuff),'"_ ,-:"',kda)))))
   would normally produce for the call %sas_maxims(1:6, 42, 52). The data step
   below -- the part that actually implements the selection algorithm -- is
   unmodified from the repo. */

%let syspbuff = 1,2,3,4,5,6,42,52;

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

%put NOTE: selected maxims = &maxims.;

/* Presentation step (not part of the repo's macro) so the result of the
   repo's own selection algorithm is visible in the listing, not just the
   log. */
data selected_maxims;
  length selector selected_maxims $ 256;
  selector = "&syspbuff.";
  selected_maxims = "&maxims.";
run;

title "maxims4sas selector logic on Jenner";
proc print data=selected_maxims noobs label;
  label selector = "Requested selector"
        selected_maxims = "Maxims selected (from the repo's own data step)";
run;
