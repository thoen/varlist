/* varlist.sas is a sas macro program which creates a comma-separated 
/* variable list based on filename including libnames and optional regular expressions */

%macro varList(libDs, regex);
	%let lib = %upcase(%scan(&libDs.,1,'.'));
	%let ds = %upcase(%scan(&libDs.,2,'.'));
proc sql noprint;
	select name into: varlist separated by ", "
		from dictionary.columns
			where upcase(libname)="&lib." and 
				upcase(memname)="&ds" 
				and	prxmatch(&regex., name)
				;
quit;
%put &varlist;
%mend varList;
%varList(work.regsys2016, "/ARB_|LONN_/");
