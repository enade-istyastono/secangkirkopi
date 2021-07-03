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
load mmp9-10b-ns15.pdb
remove /mmp9-10b-ns15//A/ZN`302/ZN
color khaki, (name C*)
select temp, /mmp9-10b-ns15//A/10B`306/*
extract lig, temp
delete temp
util.cbac lig
select bp, resi 230+236+226+227
show sticks, bp and not (name n+c+o)
deselect
set sphere_scale, 0.25, (/mmp9-10b-ns15//A/ZN`301/ZN)
distance metal,/mmp9-10b-ns15//A/ZN`301/ZN,  (name O*+N*), 2.8
color magent, metal
hide labels, metal
set_view (\
     0.581751466,   -0.086544581,    0.808739007,\
    -0.769769669,   -0.379698187,    0.513090312,\
     0.262668252,   -0.921038985,   -0.287505656,\
    -0.000914127,    0.001780398,  -48.422004700,\
     0.562328339,   -4.388413429,   64.226387024,\
  -18892.425781250, 18990.601562500,  -20.000000000 )
png 3.4.png, dpi=300, ray=1