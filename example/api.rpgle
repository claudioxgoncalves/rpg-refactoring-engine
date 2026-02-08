      *---------------------------------------------------------------------------------------------
      * PROGRAM:          API 1
      * CREATION:         XXXX.XX.XX - XXXXXXXXXX
      * CHANGE:           XXXX.XX.XX - XXXXXXXXXX
      * ROLE:             XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *---------------------------------------------------------------------------------------------
      *---------------------------------------------------------------------------------------------
      * HISTORY
      *---------------------------------------------------------------------------------------------
      *
      * 26.02.08 - CGONCALVES  TRF: AUTOMATED-REFACTORING                       Cláudio Gonçalves
      * Applied automated refactoring to an outdated source.
      *---------------------------------------------------------------------------------------------
      * STAND ALONE FIELDS
      *---------------------------------------------------------------------------------------------
     D wavar2          s              2A                                        Example variable 2
     D wavar4          s              4A                                        Example variable 4
     D wavar6          s              6A                                        Example variable 6
     D wavar7          s              7A                                        Example variable 7
     D wnvar1          s              1  0                                      Example variable 1
     D wnvar3          s              3  0                                      Example variable 3
     D wnvar5          s              5  0                                      Example variable 5
      *---------------------------------------------------------------------------------------------
      * EXAMPLE SUBROUTINE
      *---------------------------------------------------------------------------------------------
     C     subrout       begsr
     C* Times the call to PGM1
     C                   time                    wzbcall1
     C                   call      'WAPGM1'
     C* Sends
     C                   parm                    wnvar1                         Example variable 1
     C                   parm                    wavar2                         Example variable 2
     C                   parm                    wnvar3                         Example variable 3
     C                   parm                    wavar4                         Example variable 4
     C                   parm                    wnvar5                         Example variable 5
     C* Receives
     C                   parm                    wavar6                         Example variable 6
     C                   parm                    wavar7                         Example variable 7
     C                   time                    wzecall1
     C* If example variable 6 and 7 have values...
     C                   if        wavar6 <> *blanks and wavar7 <> *blanks      if
     C* times the call to PGM2                                                  |
     C                   time                    wzbcall2                       |
     C                   call      'WAPGM2'                                     |
     C                   parm                    wnvar8                         |Example variable 8
     C                   parm                    wavar9                         |Example variable 9
     C                   parm                    wnvar10                        |Example variable 10
     C                   parm                    wavar11                        |Example variable 11
     C                   parm                    wnvar12                        |Example variable 12
     C                   time                    wzecall2                       |
     C* If either example variable 6 and 7 have no value...                     |
     C                   else                                                   els
     C* clears both variables                                                   |
     C                   eval      wavar6 = *blanks                             |
     C                   eval      wavar7 = *blanks                             |
     C                   endif                                                  end
     C* Times the call to PGM3
     C                   time                    wzbcall3
     C                   call(e)   'WAPGM3'
     C                   parm                    wnvar13                        Example variable 13
     C                   parm                    wavar14                        Example variable 14
     C                   parm                    wnvar15                        Example variable 15
     C                   parm                    wavar16                        Example variable 16
     C                   parm                    wnvar17                        Example variable 17
     C                   time                    wzecall3
     C* If there was an error in the previous call...
     C                   if        %error                                       if
     C* returns an error                                                        |
     C                   eval      $rcode = 2                                   |
     C* clears additional variables                                             |
     C                   eval      wnvar13 = *zeros                             |
     C                   eval      wavar14 = *blanks                            |
     C                   eval      wnvar15 = *zeros                             |
     C                   else                                                   els
     C* times the call to PGM4                                                  |
     C                   time                    wzbcall4                       |
     C                   call      'WAPGM4'                                     |
     C* Sends                                                                   |
     C                   parm                    wnvar18                        |Example variable 18
     C                   parm                    wavar19                        |Example variable 19
     C                   parm                    wnvar20                        |Example variable 20
     C* Receives                                                                |
     C                   parm                    hilovar                        |Placeholder 1
     C                   parm                    hiloval                        |Placeholder 2
     C                   parm                    hilohed                        |Placeholder 3
     C                   parm                    hilofot                        |Placeholder 4
     C                   time                    wzecall4                       |
     C                   endif                                                  end
     C                   endsr