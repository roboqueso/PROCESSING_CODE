float xn(PVector myLoc) {
  return noise(myLoc.x * 0.0005, myLoc.y * 0.0005, myLoc.z * 0.01) * 300;
}

float yn(PVector myLoc) {
  return noise(myLoc.x * 0.0005, myLoc.y * 0.0005, myLoc.z * 0.01) * 600;
}

float sn(PVector myLoc) {
  return noise(myLoc.x * 0.005, myLoc.y * 0.005, myLoc.z * 0.03) * 100;
}

