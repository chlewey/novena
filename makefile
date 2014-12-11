#
# COMPILERS and Compiler FLAGS
#
VC = avconv
CATFLAGS = -c copy -absf aac_adtstoasc -y
AACFLAGS = -c:a aac -strict experimental -y
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
FINEu = $(addprefix fin,$(days))
FINES = $(patsubst %,bloque/%.ts,$(FINEu))
GOZOu = $(addprefix gozo-,$(gozs))
GOZOur = $(patsubst %,%r,$(GOZOu))
GOZOS = $(patsubst %,bloque/%.ts,$(GOZOu))
GOZOSp = $(patsubst %,parte/%.ts,$(GOZOu))
GOZOSr = $(patsubst %,parte/%.ts,$(GOZOur))
parts = intro todos gloria gozos-i maria ave jose padre jesus fade patreon
PARTEu = $(parts) $(DIAu) $(CREDu) $(GOZOu) $(GOZOur)
PARTES = $(patsubst %,parte/%.ts,$(PARTEu))
AUDIOS = $(patsubst %,audio/%.m4a,$(PARTEu))

all: $(NOVENAS)

$(NOVENAS): novena%.mp4: bloque/inicio.ts parte/dia%.ts bloque/medio.ts bloque/fin%.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@
	
bloque/inicio.ts: parte/intro.ts bloque/todos.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/medio.ts: bloque/maria.ts bloque/jose.ts bloque/gozos.ts bloque/jesus.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/fin%.ts: parte/creditos%.ts parte/patreon.ts parte/tube.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/todos.ts: parte/todos.ts parte/gloria.ts
	$(CV) -i "concat:parte/todos.ts|parte/gloria.ts|parte/gloria.ts|parte/gloria.ts" $(CATFLAGS) $@
	
bloque/maria.ts: parte/maria.ts parte/ave.ts
	$(CV) -i "concat:parte/maria.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts|parte/ave.ts" $(CATFLAGS) $@

bloque/jose.ts: parte/jose.ts parte/padre.ts parte/ave.ts parte/gloria.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/gozos.ts: parte/gozos-i.ts $(GOSOZ)
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

bloque/jesus.ts: parte/jesus.ts parte/fade.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(FINES): bloque/fin%.ts: parte/creditos%.ts parte/patreon.ts parte/tube.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(GOZOS): bloque/gozo-%.ts: parte/gozo-%.ts parte/gozo-%r.ts
	$(CV) -i "concat:$(subst $(space),|,$^)" $(CATFLAGS) $@

$(PARTES): parte/%.ts: audio/%.m4a muted/%.ts
	$(CV) -i audio/$*.m4a -i muted/$*.ts $(AVFLAGS) $@

$(AUDIOS): audio/%.m4a: audio/%.flac
	$(CV) -i $< $(AACFLAGS) $@

$(patsubst %,audio/%.flac,$(PARTEu)): audio/%.flac : flags/%

$(patsubst %,muted/%.ts,$(PARTEu)): muted/%.ts : flags/%

$(addprefix flags/,$(PARTEu)): flags/% :
	bash frames.sh $*
