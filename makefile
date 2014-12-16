#
# COMPILERS and Compiler FLAGS
#
VC = avconv
CATFLAGS = -c copy -y
AACFLAGS = -crf 18 -preset medium -c:a aac -ac 2 -ar 44100 -b:a 128k -strict experimental -y
AVFLAGS  = -c copy -y
space = $(eval) $(eval)

#
# Array variables
#
days=1 2 3 4 5 6 7 8 9
gozs=0 1 2 3 4 5 6 7 8 9 10 11 12
NOVENAS = $(patsubst %,novena%.mp4,$(days))
DIAu = $(addprefix dia,$(days))
DIAS = $(patsubst %,parte/%.ts,$(DIAu))
CREDu = $(addprefix creditos,$(days))
CREDS = $(patsubst %,parte/%.ts,$(CREDu))
INTROu = $(addprefix intro,$(days))
INTROS = $(patsubst %,parte/%.ts,$(INTROu))
FINEu = $(addprefix fin,$(days))
FINES = $(patsubst %,bloque/%.ts,$(FINEu))
GOZOu = $(addprefix gozo-,$(gozs))
GOZOur = $(patsubst %,%r,$(GOZOu))
GOZOS = $(patsubst %,bloque/%.ts,$(GOZOu))
GOZOSp = $(patsubst %,parte/%.ts,$(GOZOu))
GOZOSr = $(patsubst %,parte/%.ts,$(GOZOur))
parts = intro todos gloria gozos-i maria ave jose padre jesus fade patreon
PARTEu = $(parts) $(DIAu) $(CREDu) $(GOZOu) $(GOZOur) $(INTROu)
PARTES = $(patsubst %,parte/%.ts,$(PARTEu))
AUDIOS = $(patsubst %,audios/%.m4a,$(PARTEu))
MUTES =  $(patsubst %,muted/%.ts,$(PARTEu))

all: test.mp4 $(NOVENAS)

test.mp4: parte/intro1.ts parte/todos.ts parte/tube.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(NOVENAS): novena%.mp4: parte/intro%.ts bloque/todos.ts parte/dia%.ts bloque/medio.ts bloque/fin%.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@
	
#bloque/inicio.ts: parte/intro.ts bloque/todos.ts
#	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/medio.ts: bloque/maria.ts bloque/jose.ts bloque/gozos.ts bloque/jesus.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/fin%.ts: parte/creditos%.ts parte/patreon.ts parte/tube.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/todos.ts: parte/todos.ts parte/gloria.ts
	$(VC) -i "concat:parte/todos.ts|parte/gloria.ts|parte/gloria.ts|parte/gloria.ts" $(CATFLAGS) $@
	
bloque/maria.ts: parte/maria.ts parte/ave.ts
	$(VC) -i "concat:parte/maria.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts" $(CATFLAGS) $@

bloque/jose.ts: parte/jose.ts parte/padre.ts parte/ave.ts parte/gloria.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/gozos.ts: parte/gozos-i.ts $(GOZOS)
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/jesus.ts: parte/jesus.ts parte/fade.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(FINES): bloque/fin%.ts: parte/creditos%.ts parte/patreon.ts parte/tube.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(GOZOS): bloque/gozo-%.ts: parte/gozo-%.ts parte/gozo-%r.ts
	$(VC) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(PARTES): parte/%.ts: audios/%.m4a muted/%.ts
	$(VC) -i audios/$*.m4a -i muted/$*.ts $(AVFLAGS) $@

$(AUDIOS): audios/%.m4a: audios/%.flac
	$(VC) -i $< $(AACFLAGS) $@

#$(patsubst %,audios/%.flac,$(PARTEu)): audios/%.flac : flags/%

$(MUTES): muted/%.ts :
	bash frames.sh $*
