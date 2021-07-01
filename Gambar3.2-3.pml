#PyMOL pengaturan awal
bg white
set valence, 0
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
load 4h3x.pdb
remove sol.
remove chain B
remove */CA*/CA
remove */GOL*/*
remove */PGO*/*
remove /4h3x//A/ZN`302/ZN
color khaki, (name C*)
select temp, /4h3x//A/10B`306/*
extract lig, temp
delete temp
util.cbac lig
select bp, resi 230+236+226+227
show sticks, bp and not (name n+c+o)
deselect
set sphere_scale, 0.25, (/4h3x//A/ZN`301/ZN)
distance metal,/4h3x//A/ZN`301/ZN, all, 2.5
color magent, metal
hide labels, metal
set_view (\
     0.739955664,   -0.569638968,   -0.357730538,\
    -0.655010223,   -0.731196702,   -0.190536737,\
    -0.153034508,    0.375302225,   -0.914176762,\
    -0.000008177,   -0.000078090, -110.447677612,\
     4.624387741,   -0.463886499,   11.534814835,\
  -11831.041015625, 12051.985351562,  -20.000000000 )
png 3.2.png, dpi=300, ray=1 
set_view (\
     0.739955664,   -0.569638968,   -0.357730538,\
    -0.655010223,   -0.731196702,   -0.190536737,\
    -0.153034508,    0.375302225,   -0.914176762,\
     0.000000156,    0.000000238,  -43.581935883,\
     8.249834061,    5.171212196,    8.935218811,\
  -11897.901367188, 11985.125000000,  -20.000000000 )
png 3.3.png, dpi=300, ray=1