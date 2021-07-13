#PyMOL pengaturan awal
bg white
set valence, 1
set ray_opaque_background, 0
set ray_shadows,0 
set cartoon_oval_quality, 9
set cartoon_oval_length, 0.7
set cartoon_oval_width, 0.05
set cartoon_rect_length, 1.2
set cartoon_rect_width, 0.05
set_color khaki=[0.95 , 0.90 , 0.55]
viewport 640,480
#Mulai pembuatan gambar
load mmp9-cac-ns15.pdb
remove /mmp9-cac-ns15//A/ZN`302/ZN
color khaki, (name C*)
select temp, /mmp9-cac-ns15//A/UNL`1/*
extract lig, temp
delete temp
util.cbac lig
select bp, resi 230+236+226+227
show sticks, bp and not (name n+c+o)
deselect
set sphere_scale, 0.25, (/mmp9-cac-ns15//A/ZN`301/ZN)
distance metal,/mmp9-cac-ns15//A/ZN`301/ZN,  (name O*+N*), 2.8
distance metal2, /mmp9-cac-ns15//A/ZN`301/ZN, /lig/C001/A/UNL`1/O, 3.9
color magent, metal
color yellow, metal2
hide labels, metal*
set_view (\
     0.788073182,   -0.294419110,    0.540591955,\
    -0.607109427,   -0.226743311,    0.761563241,\
    -0.101647370,   -0.928369582,   -0.357429504,\
     0.000054527,    0.002170786,  -42.171405792,\
    -1.397442818,    0.726835251,   58.845138550,\
  -43898.203125000, 43984.824218750,  -20.000000000 )
png 3.5.png, dpi=300, ray=1