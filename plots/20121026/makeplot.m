function makeplot()

plot_2008_republican_primary_tx_harris();
plot_2008_democratic_primary_tx_harris();
plot_2008_general_election_tx_harris();

plot_2008_republican_primary_tx_dallas();
plot_2008_democratic_primary_tx_dallas();
plot_2008_general_election_tx_dallas();

plot_2012_republican_primary_tx_harris();
plot_2012_democratic_primary_tx_harris();

plot_2012_republican_primary_tx_dallas();
plot_2012_democratic_primary_tx_dallas();

%%
function data = load_data(ci, idx)

% load data from manually processed text file.
% ci is a struct containing case information for a particular election
% event in a particular county. the filename is constructed using this
% information, so if there isn't a file matching the specified case this
% will return an error.

% data files must have one precinct's results on each line, space
% delimited. some cases are split between multiple files, use the idx
% parameter to specify which file you want, and leave it unspecified if
% the case has only one file.

% ex: ../../data/tx/harris/20081104_general_election_tx_harris
data_dir = ['../../data/' ci.state_fn '/' ci.county_fn '/' ci.date_fn '_' ci.election_fn '_' ci.state_fn '_' ci.county_fn];

suffix = '';
if nargin > 1
  suffix = ['_' num2str(idx)];
end

% ex: 20081104_general_election_president_tx_harris_1.txt
data_filename = [data_dir '/' ci.date_fn '_' ci.election_fn '_' ci.event_fn '_' ci.state_fn '_' ci.county_fn suffix '.txt'];
data = load(data_filename);


%%
function plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci)

% 1. Calculate the total number of ballots cast in each precinct.
totals = sum(allvotes,2);

% 2. Sort precincts from least to most ballots cast.
[totals_sorted, idx_sorted] = sort(totals);
allvotes_sorted = allvotes(idx_sorted,:);

% 3. Compute a cumulative sum for the votes cast for each candidate from
% smallest precincts to largest precincts.  Do the same for the ballot
% totals.
cumulativevotes = cumsum(allvotes_sorted);
cumulativetotals = cumsum(totals_sorted);

% 4. Divide cumulative vote total by cumulative ballot total to get
% cumulative vote share percentages for each candidate.
cumulativepercents = bsxfun(@rdivide, cumulativevotes, cumulativetotals);

% 5. Plot cumulative vote share percent vs cumulative ballots cast for each
% candidate
close
figure(1)
hold on
for i = 1:size(cumulativepercents,2);
  plot(cumulativetotals, cumulativepercents(:,i), '.-', 'Color', ci.cmap(i,:))
end
title([ci.year ' ' ci.election ' (' ci.event ') - ' ci.county ', ' ci.state ' - Per-Precinct Election Results, Cumulative'])
xlabel('Cumulative ballots')
ylabel('Percent vote share')
legend(ci.candidates,'Location','BestOutside')
plot_filename = [ci.date_fn '_' ci.election_fn '_' ci.event_fn '_' ci.state_fn '_' ci.county_fn '.png'];
print('-dpng', '-f1', plot_filename)


%%
function [plot_filename] = plot_2012_republican_primary_tx_harris()

ci = struct;
ci.year = '2012';
ci.election = 'Republican Primary';
ci.event = 'President';
ci.county = 'Harris County';
ci.state = 'TX';
ci.date_fn = '20120529';
ci.election_fn = 'republican_primary';
ci.event_fn = 'president';
ci.county_fn = 'harris';
ci.state_fn = 'tx';
ci.candidates = {'Paul','Gingrich','Davies','Santorum','Roemer', ...
                 'Huntsman','Romney','Bachmann','Uncommitted'};
ci.cmap = [ 0 .8 .8; ... % Paul
            0 .5  0; ... % Gingrich
            1 .5 .2; ... % Davies
           .5 .5  0; ... % Santorum
            0 .5  0; ... % Roemer
            0  0  1; ... % Huntsman
            1  0  0; ... % Romney
            1 .7 .7; ... % Bachmann
            0  0  0];    % Uncommitted

data1 = load_data(ci, 1);

% when copying the text from the pdf, it copies the columns in an odd
% order (note Percent Turnout is between Roemer and Huntsman and Election
% Ballots Cast is after Bachmann)

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Ron Paul
% 06 Newt Gingrich
% 07 John Davies
% 08 Rick Santorum
% 09 Charles "Buddy" Roemer
% 10 Percent Turnout
% 11 Jon Huntsman
% 12 Mitt Romney
% 13 Michele Bachmann
% 14 Election Ballots Cast

% there wasn't enough space per page to fit all columns in the original
% pdf, so the next file is a continuation (starting from p.33 in the pdf)
data2 = load_data(ci, 2);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Percent Turnout
% 06 "Uncommitted"
% 07 Totals
% 08 Election Ballots Cast

allvotes = [data1(:,[5:9 11:13]) data2(:,6)];
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);


%%
function [plot_filename] = plot_2012_democratic_primary_tx_harris()

ci = struct;
ci.year = '2012';
ci.election = 'Democratic Primary';
ci.event = 'President';
ci.county = 'Harris County';
ci.state = 'TX';
ci.date_fn = '20120529';
ci.election_fn = 'democratic_primary';
ci.event_fn = 'president';
ci.county_fn = 'harris';
ci.state_fn = 'tx';
ci.candidates = {'Wolfe', 'Ely', 'Obama', 'Richardson'};
ci.cmap = [ 1  0  0; ... % Wolfe
            0 .8  0; ... % Ely
            0  0  1; ... % Obama
           .5  0 .5];    % Richardson

data = load_data(ci);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 John Wolfe
% 06 Bob Ely
% 07 Barack Obama
% 08 Darcy G. Richardson
% 09 Totals
% 10 Percent Turnout
% 11 Election Ballots Cast

allvotes = data(:,5:8);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);


%%
function [plot_filename] = plot_2008_republican_primary_tx_harris()

ci = struct;
ci.year = '2008';
ci.election = 'Republican Primary';
ci.event = 'President';
ci.county = 'Harris County';
ci.state = 'TX';
ci.date_fn = '20080304';
ci.election_fn = 'republican_primary';
ci.event_fn = 'president';
ci.county_fn = 'harris';
ci.state_fn = 'tx';
ci.candidates = {'Hunter','Thompson','Cort','McCain','Paul','Giuliani', ...
                 'Tran','Huckabee','Keyes','Romney','Uncommitted'};
ci.cmap = [ 0 .5  0; ... % Hunter
            0  0 .5; ... % Thompson
            1 .5 .2; ... % Cort
            1  0  0; ... % McCain
            0 .8 .8; ... % Paul
           .7  1 .7; ... % Giuliani
            1 .7 .7; ... % Tran
            0  0  1; ... % Huckabee
           .7 .7  1; ... % Keyes
           .5  0  0; ... % Romney
            0  0  0];    % Uncommitted

data1 = load_data(ci, 1);

% 01 Precinct
% 02 Early Voting Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Duncan Hunter
% 06 Fred Thompson
% 07 Hugh Cort
% 08 John McCain
% 09 Ron Paul
% 10 Percent Turnout
% 11 Rudy Giuliani
% 12 Hoa Tran
% 13 Mike Huckabee
% 14 Election Day Ballots Cast

data2 = load_data(ci, 2);

% 01 Precinct
% 02 Early Voting Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Percent Turnout
% 06 Alan Keyes
% 07 Mitt Romney
% 08 "Uncommitted"
% 09 Totals
% 10 Election Day Ballots Cast

allvotes = [data1(:,[5:9 11:13]) data2(:,6:8)];
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);


%%
function [plot_filename] = plot_2008_democratic_primary_tx_harris()

ci = struct;
ci.year = '2008';
ci.election = 'Democratic Primary';
ci.event = 'President';
ci.county = 'Harris County';
ci.state = 'TX';
ci.date_fn = '20080304';
ci.election_fn = 'democratic_primary';
ci.event_fn = 'president';
ci.county_fn = 'harris';
ci.state_fn = 'tx';
ci.candidates = {'Obama','Dodd','Clinton','Biden','Richardson','Edwards'};
ci.cmap = [ 0  0  1; ... % Obama
            1 .7 .7; ... % Dodd
            1  0  0; ... % Clinton
           .7 .7  1; ... % Biden
           .5  0 .5; ... % Richardson
           .7  1 .7];    % Edwards

data = load_data(ci);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Barack Obama
% 06 Christopher J. Dodd
% 07 Hillary Clinton
% 08 Joe Biden
% 09 Bill Richardson
% 10 Percent Turnout
% 11 John Edwards
% 12 Totals
% 13 Election Ballots Cast

allvotes = data(:,[5:9 11]);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);

%%
function [plot_filename] = plot_2008_general_election_tx_harris()

ci = struct;
ci.year = '2008';
ci.election = 'General Election';
ci.event = 'President';
ci.county = 'Harris County';
ci.state = 'TX';
ci.date_fn = '20081104';
ci.election_fn = 'general_election';
ci.event_fn = 'president';
ci.county_fn = 'harris';
ci.state_fn = 'tx';
ci.candidates = {'McCain/Palin','Obama/Biden','Barr/Root','Baldwin/Castle', ...
                 'McKinney/Clemente','Nader/Gonzalez','Allen/Stath', ...
                 'Hill/Bailey','Keyes/Sprouse','Moore/Alexander'};
ci.cmap = [ 1  0  0; ... % McCain/Palin
            0  0  1; ... % Obama/Biden
           .5  0  0; ... % Barr/Root
           .7 .7  1; ... % Baldwin/Castle
           .5  0 .5; ... % McKinney/Clemente
           .7  1 .7; ... % Nader/Gonzalez
            1 .5 .2; ... % Allen/Stath
            0 .8 .8; ... % Hill/Bailey
            1 .7 .7; ... % Keyes/Sprouse
            0 .5  0];    % Moore/Alexander

data1 = load_data(ci, 1);

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 McCain/Palin
% 06 Obama/Biden
% 07 Barr/Root
% 08 Baldwin/Castle
% 09 McKinney/Clemente
% 10 Percent Turnout
% 11 Nader/Gonzalez
% 12 Allen/Stath
% 13 Hill/Bailey
% 14 Election Ballots Cast

data2 = load_data(ci, 2);

% 01 Precinct
% 02 Early Ballots
% 03 Total Ballots Cast
% 04 Percent Turnout
% 05 Keyes/Sprouse
% 06 Moore/Alexander
% 07 Totals
% 08 Election Ballots Cast

allvotes = [data1(:,[5:9 11:13]) data2(:,5:6)];
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);

%%
function [plot_filename] = plot_2008_republican_primary_tx_dallas()

ci = struct;
ci.year = '2008';
ci.election = 'Republican Primary';
ci.event = 'President';
ci.county = 'Dallas County';
ci.state = 'TX';
ci.date_fn = '20080304';
ci.election_fn = 'republican_primary';
ci.event_fn = 'president';
ci.county_fn = 'dallas';
ci.state_fn = 'tx';
ci.candidates = {'Cort','McCain','Hunter','Thompson','Giuliani','Tran', ...
                 'Romney','Keyes','Huckabee','Paul','Uncommitted'};
ci.cmap = [ 1 .5 .2; ... % Cort
            1  0  0; ... % McCain
            0 .5  0; ... % Hunter
            0  0 .5; ... % Thompson
           .7  1 .7; ... % Giuliani
            1 .7 .7; ... % Tran
           .5  0  0; ... % Romney
           .7 .7  1; ... % Keyes
            0  0  1; ... % Huckabee
            0 .8 .8; ... % Paul
            0  0  0];    % Uncommitted

% Dallas County uses word docs for precinct results, so we don't have
% weird copying behavior.  The files still need to be manually processed
% before MATLAB can read them, though.
          
data = load_data(ci);

% 01 Precinct
% 02 Hugh Cort
% 03 John McCain
% 04 Duncan Hunter
% 05 Paul Thompson
% 06 Rudy Giuliani
% 07 Hoa Tran
% 08 Mitt Romney
% 09 Alan Keyes
% 10 Mike Huckabee
% 11 Ron Paul
% 12 Uncommitted

allvotes = data(:,2:12);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);

%%
function [plot_filename] = plot_2008_democratic_primary_tx_dallas()

ci = struct;
ci.year = '2008';
ci.election = 'Democratic Primary';
ci.event = 'President';
ci.county = 'Dallas County';
ci.state = 'TX';
ci.date_fn = '20080304';
ci.election_fn = 'democratic_primary';
ci.event_fn = 'president';
ci.county_fn = 'dallas';
ci.state_fn = 'tx';
ci.candidates = {'Dodd','Edwards','Obama','Richardson','Clinton','Biden'};
ci.cmap = [ 1 .7 .7; ... % Dodd
           .7  1 .7; ... % Edwards
            0  0  1; ... % Obama
           .5  0 .5; ... % Richardson
            1  0  0; ... % Clinton
           .7 .7  1];    % Biden

data = load_data(ci);

% 01 Precinct
% 02 Christopher J. Dodd
% 03 John Edwards
% 04 Barack Obama
% 05 Bill Richardson
% 06 Hillary Clinton
% 07 Joe Biden

allvotes = data(:,2:7);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);


%%
function [plot_filename] = plot_2008_general_election_tx_dallas()

ci = struct;
ci.year = '2008';
ci.election = 'General Election';
ci.event = 'President';
ci.county = 'Dallas County';
ci.state = 'TX';
ci.date_fn = '20081104';
ci.election_fn = 'general_election';
ci.event_fn = 'president';
ci.county_fn = 'dallas';
ci.state_fn = 'tx';
ci.candidates = {'McCain/Palin','Obama/Biden','Barr/Root','WRITE-IN'};
ci.cmap = [ 1  0  0; ... % McCain/Palin
            0  0  1; ... % Obama/Biden
           .5  0  0; ... % Barr/Root
            0  0  0];    % WRITE-IN

data = load_data(ci);

% 01 Precinct
% 02 John McCain/Sarah Palin (REP)
% 03 Barack Obama/Joe Biden (DEM)
% 04 Bob Barr/Wayne A. Root (LIB)
% 05 WRITE-IN

allvotes = data(:,2:5);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);

%%
function [plot_filename] = plot_2012_republican_primary_tx_dallas()

ci = struct;
ci.year = '2012';
ci.election = 'Republican Primary';
ci.event = 'President';
ci.county = 'Dallas County';
ci.state = 'TX';
ci.date_fn = '20120529';
ci.election_fn = 'republican_primary';
ci.event_fn = 'president';
ci.county_fn = 'dallas';
ci.state_fn = 'tx';
ci.candidates = {'Gingrich','Davis','Huntsman','Roemer','Santorum', ...
                 'Bachmann','Paul','Romney','Uncommitted'};
ci.cmap = [ 0 .5  0; ... % Gingrich
            1 .5 .2; ... % Davis
            0  0  1; ... % Huntsman
            0 .5  0; ... % Roemer
           .5 .5  0; ... % Santorum
            1 .7 .7; ... % Bachmann
            0 .8 .8; ... % Paul
            1  0  0; ... % Romney
            0  0  0];    % Uncommitted

data = load_data(ci);

% 01 Precinct
% 02 Newt Gingrich
% 03 John Davis
% 04 Jon Huntsman
% 05 Charles "Buddy" Roemer
% 06 Rick Santorum
% 07 Michele Bachmann
% 08 Ron Paul
% 09 Mitt Romney
% 10 Uncommitted

allvotes = data(:,2:10);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);


%%
function [plot_filename] = plot_2012_democratic_primary_tx_dallas()

ci = struct;
ci.year = '2012';
ci.election = 'Democratic Primary';
ci.event = 'President';
ci.county = 'Dallas County';
ci.state = 'TX';
ci.date_fn = '20120529';
ci.election_fn = 'democratic_primary';
ci.event_fn = 'president';
ci.county_fn = 'dallas';
ci.state_fn = 'tx';
ci.candidates = {'Obama','Wolfe','Richardson','Ely'};
ci.cmap = [ 0  0  1; ... % Obama
            1  0  0; ... % Wolfe
           .5  0 .5; ... % Richardson
            0 .8  0];    % Ely

data = load_data(ci);

% 01 Precinct
% 02 Barack Obama
% 03 John Wolfe
% 04 Darcy G. Richardson
% 05 Bob Ely

allvotes = data(:,2:5);
plot_filename = plot_cumulative_ballots_vs_vote_share(allvotes, ci);
