********* WWS5954j CPS ********
*  Spring 2018			      *
*  Author : Joelle Gamble     *
*  Email: jcgamble@           *
*******************************

clear all

*Set directory, dta file, etc.
use cps_00001.dta,clear
ssc install mdesc
ssc install outreg2
set more off

//Relabel variables to something I can remember//

rename cpsid household_id
rename serial household_serial
rename occ occupation
rename occ2010 occupation2010
rename classwkr workerclass
rename occ_mom occupationmom
rename occ_pop occupationdad
rename classwkr_mom workerclassnmom
rename classwkr_pop workerclassdad

//Summarize certification and licensing data

tab profcert year
tab statecert year 
tab jobcert year

//Generate managerial variable

gen manager=1 if occupation==0010
replace manager=0 if occupation==0 
replace manager=1 if occupation==0020
replace manager=1 if occupation==0040
replace manager=1 if occupation==0050
replace manager=1 if occupation==0060
replace manager=1 if occupation==0100
replace manager=1 if occupation==0110
replace manager=1 if occupation==0120
replace manager=1 if occupation==0130
replace manager=1 if occupation==0140
replace manager=1 if occupation==0150
replace manager=1 if occupation==0160
replace manager=1 if occupation==0200
replace manager=1 if occupation==0160
replace manager=1 if occupation==0210
replace manager=1 if occupation==0220
replace manager=1 if occupation==0220
replace manager=1 if occupation==0230
replace manager=1 if occupation==0300
replace manager=1 if occupation==0310
replace manager=1 if occupation==0320
replace manager=1 if occupation==0330
replace manager=1 if occupation==0340
replace manager=1 if occupation==0350
replace manager=1 if occupation==0360
replace manager=1 if occupation==0410
replace manager=1 if occupation==0420
replace manager=1 if occupation==0430
replace manager=0 if occupation>=1000

//Generate healthcare worker variables
**High level (doctors, etc)

**Specialist (defined as requiring formal education) 


**Rank and file


