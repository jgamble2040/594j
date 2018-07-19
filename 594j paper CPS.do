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

tab profcert year, row
tab statecert year 
tab jobcert year

sum profcert statecert jobcert if year>=2016

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

//Generate Senior Care worker variables

**Healthcare general*
gen healthcare=1 if occupation>=3000
replace healthcare=0 if occupation>=3700
replace healthcare=0 if occupation<3000
tab healthcare
//217,231 observations

**healthcare including potential senior care home aides
gen health_personal=1 if healthcare==1
replace health_personal=0 if healthcare==0
replace health_personal=1 if personalcare==1

**High level (doctors, etc)
gen advhealthcare=1 if occupation==3000
replace advhealthcare=0 if occupation>3000
replace advhealthcare=0 if occupation<3000
replace advhealthcare=1 if occupation==3010
replace advhealthcare=1 if occupation==3040
replace advhealthcare=1 if occupation==3050
replace advhealthcare=1 if occupation==3060
replace advhealthcare=1 if occupation==3120
replace advhealthcare=1 if occupation==3010

**Healthcare support
gen healthsupport=1 if occupation>=3600
replace healthsupport=0 if occupation>3620
replace healthsupport=1 if occupation==4610

**Likely to include my workers of interest
gen personalcare=1 if occupation==4610
replace personalcare=0 if occupation>4610
replace personalcare=0 if occupation<4610

tab personalcare
// 24,178 observations. Less than 1%

//Percentage of home and health aides with required certification
tab personalcare reqcert, row
corr personalcare reqcert
*negative correlation

//Separating worker class
gen unpaidfamily=0 if workerclass==!29
replace unpaidfamily=1 if workerclass==29

gen unpaidfamily=0 if workerclass==!29
replace unpaidfamily=1 if workerclass==29

// analysis

**Correlation between managers and certifications
corr statecert manager
*-0.06
corr jobcert manager
*-0.079
corr profcert manager
*-0.117


**Are public or private sector workers more likely to have certification if in qualifying job


gen reqcert=1 if jobcert==2
replace reqcert=0 if jobcert==1
replace reqcert=. if jobcert==99

reg reqcert workerclass, r
