% the following file was created by performing "select all" on the pdf
% and pasting the results into a text document. then, all extraneous
% text besides the presidential primary results were edited out manually.
harris1 = load('20120529_republican_primary_president_tx_harris_1.txt');

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
% 10 Percent Turnout ***
% 11 Jon Huntsman
% 12 Mitt Romney
% 13 Michele Bachmann
% 14 Election Ballots Cast ***

% there wasn't enough space per page to fit all columns in the original
% pdf, so the next file is a continuation (starting from p.33 in the pdf)
harris2 = load('20120529_republican_primary_president_tx_harris_2.txt');

% similar copy/paste issue again, Election Ballots Cast is after Totals

% 01 Precinct
% 02 Early Ballots Cast
% 03 Total Ballots Cast
% 04 Registered Voters
% 05 Percent Turnout
% 06 "Uncommitted"
% 07 Totals
% 08 Election Ballots Cast ***

% extract columns

precinct         = harris1(:,1);
earlyballots     = harris1(:,2);
electionballots  = harris1(:,14);
totalballots     = harris1(:,3);
registeredvoters = harris1(:,4);
percentturnout   = harris1(:,10);

paul        = harris1(:,5);
gingrich    = harris1(:,6);
davies      = harris1(:,7);
santorum    = harris1(:,8);
roemer      = harris1(:,9);
huntsman    = harris1(:,11);
romney      = harris1(:,12);
bachmann    = harris1(:,13);
uncommitted = harris2(:,6);
totals      = harris2(:,7);

% when duplicate data is available, use it to check against

assert(all(precinct == harris2(:,1)))
assert(all(earlyballots == harris2(:,2)))
assert(all(electionballots == harris2(:,8)))
assert(all(totalballots == harris2(:,3)))
assert(all(registeredvoters == harris2(:,4)))
assert(all(percentturnout == harris2(:,5)))

% now, convert from raw vote totals to percentages

allvotes = [paul, gingrich, davies, santorum, roemer, huntsman, romney, bachmann, uncommitted];
%precinctsize = totalballots ./ (.01 * percentturnout);
precinctsize = totals;
allpercents = bsxfun(@rdivide, allvotes, precinctsize);

% plot percents against precinct size for each candidate

figure(1)
hold on
cmap = colormap;
for i = 1:size(allpercents,2)
  plot(precinctsize, allpercents(:,i), '.', 'Color', cmap(5*i,:))
end
