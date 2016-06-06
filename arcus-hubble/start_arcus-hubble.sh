docker run -it -p 25828:25828 -p 25829:25829 -p 25832:25832 -p 2181:2181 -p 11211:11211 -p 11212:11212 -p 3000:3000 -p 8080:8080 -p 8007:8007 --rm --name=arcus-hubble diri/arcus-hubble_image
#docker run -it -p 25828:25828 -p 25829:25829 -p 25832:25832 -p 3000:3000 -p 8080:8080 -p 8007:8007 --link arcus:arcus --rm --name=arcus-hubble diri/arcus-hubble_image
