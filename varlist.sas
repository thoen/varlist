/* varlist.sas creates a comma-separated variable list based on */
/* filename including libnames and optional regular expressions */

%macro varList(libDs, regex);
	%let lib = %upcase(%scan(&libDs.,1,'.'));
	%let ds = %upcase(%scan(&libDs.,2,'.'));
proc sql noprint;
	select name into: varlist separated by ", "
		from dictionary.columns
			where upcase(libname)="&lib." and 
				upcase(memname)="&ds" 
				%if %symexist(&regex.) %then %do;
				and	prxmatch("&regex.", name)
				%end;
				;
quit;
%mend varList;

/* %varList(work.regsys2016, /ARB_|LONN_/); */
/* %varList(work.regsys2016); */
/* %put &varlist.; */
