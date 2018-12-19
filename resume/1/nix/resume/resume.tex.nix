##################################################
{ tex ? import ./tex.nix {}
, cv  ? import ./cv.nix  { inherit tex; }
}:

##################################################
{ class
, fontsize

, contact
, education
, career
, honors ? []
}:

##################################################
let

##################################################

in
##################################################
''
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Every LaTeX document has a document class. 
%% For this document, I will use a custom resume class.

${tex.documentclass { inherit fontsize class; }}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Next, I’ll provide some semantic information. 
%% Each of these commands is defined in the résumé class. 

${cv.mkContact contact}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% This begins the document.
%% The command makecvheader is from resume.cls and will setup the basic template.

\begin{document}

\makecvheader[C]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\cvsection{Education}

${cv.mkEducation { indentation = 2; } education}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\cvsection{Work Experience}

${cv.mkCareer { indentation = 2; } career}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %% NOTE
  %% Each « cvsection » is composed of multiple « cventries ».

  %% Visually:
  %% 
  %% | left         | right        |
  %% |--------------+--------------|
  %% | argument 1   | /argument 2/ |
  %% | /argument 3/ | /argument 4/ |

  %% Semantically:
  %% 
  %% | left                  | right                   |
  %% |-----------------------+-------------------------|
  %% | Company or University | /Location/              |
  %% | /Position or degree/  | /Start date - end date/ |

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

  %% ${if honors != [] then ''\cvsection{Honors \& Awards}'' else ""}

  %% TODO honors
  %% 
  %% \begin{cvhonors}
  %% 
  %%   \cvhonor
  %%   {3rd Place}
  %%   {JayHacks Hackathon}
  %%   {Lawrence, KS, USA}
  %%   {2017}
  %% 
  %%   \cvhonor
  %%   {Grand Prize}
  %%   {Google Code-in}
  %%   {Mountain View, CA, USA}
  %%   {2013}
  %% 
  %% \end{cvhonors}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\makecvfooter
    {SBOOSALI}
    {\thepage}
    {1}         %% {\pageref{LastPage}}

 %% The =makecvfooter= command gives a nice footer that will be put at the bottom
 %% of each page. This can give us the document title and page numbering. In
 %% addition, the LastPage command will tell us how many pages there are in case
 %% we misplace a page while printing.

\end{document}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
''
