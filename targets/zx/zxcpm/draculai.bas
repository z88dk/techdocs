168 REM *********    INSTRUCTIONS     ***********
169 GOSUB 215:PRINT:PRINT:PRINT TAB(6);:GOSUB 224:PRINT"D R A C U L A ' S  C A S T L E":GOSUB 230
170 PRINT:PRINT
171 GOSUB 227
172 PRINT" Dracula's Castle has a concealed goal.":PRINT"You will learn the goal by exploring "
173 PRINT"your surroundings.  The computer will":PRINT"act as you hands and eyes. It will accept"
174 PRINT"short phrases as commands and assumes":PRINT"that the first word is a verb and the "
175 PRINT"last word is the object. For example: ":GOSUB 230:PRINT:PRINT" READ THE SIGN ":GOSUB 227:GOSUB 300
176 PRINT"The computer has a vocabulary of about":PRINT"  70 words.  Some of the more important"
177 PRINT"words you should know before":PRINT"you start playing are:":GOSUB 230:PRINT:PRINT"GET (obj), DROP (obj), LOOK (obj) ":GOSUB 227
178 PRINT"or just ";:GOSUB 230:PRINT"LOOK, GO (direction) ":GOSUB 227:PRINT"or ";:GOSUB 230:PRINT"(PLACE)";:GOSUB 227:PRINT", and ";:GOSUB 230:PRINT"INVENTORY ";:GOSUB 227:PRINT" (tells what you are carrying)."
179 PRINT"The computer knows the abbreviations: ":GOSUB 230:PRINT"E, W, N, S, U, ";:GOSUB 227:PRINT"and ";:GOSUB 230:PRINT"D ";:GOSUB 227:PRINT"for ";:GOSUB 230:PRINT"GO EAST, GO WEST, ";:GOSUB 227:PRINT"etc.":PRINT:GOSUB 300
180 PRINT" The computer's vocabulary is good,":PRINT"but limited. If you are having trouble"
181 PRINT"doing something, try re-phrasing the": PRINT "command or you may need some object to"
182 PRINT"accomplish the task. By the way,":PRINT"the computer only looks at the first 3 "
183 PRINT"letters of each word.":GOSUB 230
184 PRINT:PRINT TAB(5);"--- GOOD LUCK ---":PRINT:PRINT
185 INPUT"Press return to continue.....",A$
186 GOSUB 215
187 CHAIN "DRACULA.BAS"
213 REM *******************     ESCAPE CODES     ******************
214 REM
215 REM ************     CLS     *********
216 PRINT CHR$(12);:RETURN
217 REM
218 REM ***********     NORMAL FLASH   *************
219 RETURN
220 REM
221 REM ***********     REVERSE NORMAL FLASH    **************
222 RETURN
223 REM
224 REM **********      NORMAL UNDERLINE   **************
225 RETURN
226 REM
227 REM ***********     LOW LIGHT      *************
228 RETURN
229 REM
230 REM ***********      RESET       **********
231 RETURN
232 REM
300 PRINT:PRINT:INPUT"Press return to continue.....",A$
310 GOSUB 216:RETURN
