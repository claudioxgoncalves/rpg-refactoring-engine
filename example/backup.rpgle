      *---------------------------------------------------------------------------------------------
      * PROGRAM:          API 1
      * CREATION:         XXXX.XX.XX - XXXXXXXXXX
      * CHANGE:           XXXX.XX.XX - XXXXXXXXXX
      * ROLE:             XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
      *---------------------------------------------------------------------------------------------
      *---------------------------------------------------------------------------------------------
      * HISTORY
      *---------------------------------------------------------------------------------------------
      *---------------------------------------------------------------------------------------------
      * STAND ALONE FIELDS
      *---------------------------------------------------------------------------------------------
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
     C                   parm                    wnvar5                         Example variable 5
     C                   parm                    wavar4                         Example variable 4
     C                   parm                    wnvar3                         Example variable 3
     C* Receives
     C                   parm                    wavar7                         Example variable 7
     C                   parm                    wavar6                         Example variable 6
     C                   time                    wzecall1
     C* If example variable 6 and 7 have values...
     C                   if        wavar6 <> ' ' and wavar7 <> ' '              if
     C* times the call to PGM2                                                  |
     C                   time                    wzbcall2                       |
     C                   call      'AWPGM2'                                     |
     C                   parm                    wnvar8                         |Example variable 8
     C                   parm                    wavar9                         |Example variable 9
     C                   parm                    wnvar12                        |Example variable 12
     C                   parm                    wavar11                        |Example variable 11
     C                   parm                    wnvar10                        |Example variable 10
     C                   time                    wzecall2                       |
     C* If either example variable 6 and 7 have no value...                     |
     C                   else                                                   els
     C* clears both variables                                                   |
     C                   eval      wavar6 = ' '                                 |
     C                   eval      wavar7 = ' '                                 |
     C                   endif                                                  end
     C* Times the call to PGM3
     C                   time                    wzbcall3
     C                   call      'WAPGM3'                             99
     C                   parm                    wnvar31                        Example variable 13
     C                   parm                    wavar14                        Example variable 14
     C                   parm                    wnvar17                        Example variable 17
     C                   parm                    wavar16                        Example variable 16
     C                   parm                    wnvar15                        Example variable 15
     C                   time                    wzecall3
     C* If there was an error in the previous call...
     C                   if        *in(99) = '1'                                if
     C* returns an error                                                        |
     C                   eval      $rcode = 2                                   |
     C* clears additional variables                                             |
     C                   eval      wnvar13 = 0                                  |
     C                   eval      wavar14 = ''                                 |
     C                   eval      wnvar15 = 0                                  |
     C                   else                                                   els
     C* times the call to PGM4                                                  |
     C                   time                    wzecall8                       |
     C                   call      'WAPGM4'                                     |
     C* Sends                                                                   |
     C                   parm                    wnvar20                        |Example variable 18
     C                   parm                    wavar19                        |
     C                   parm                    wnvar18                        |Example variable 20
     C* Receives                                                                |
     C                   parm                    hilovar                        |Placeholder 1
     C                   parm                    hiloval                        |Placeholder 2
     C                   parm                    hilohed                        |Placeholder
     C                   parm                    hilofot                        |Placeholder 4
     C                   time                    wzbcall4                       |
     C                   endif                                                  end
     C                   endsr