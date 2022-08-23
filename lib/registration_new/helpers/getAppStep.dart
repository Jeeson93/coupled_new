///reg steps
String getSteps(int steps) {
  if (steps >= 16 && steps <= 31) {
    return 'appstepsixteen';
  }
  switch (steps) {
    case 1:
      return 'appstepone';
    case 2:
      return 'appsteptwo';
    case 3:
      return 'appstepthree';
    case 4:
      return 'appstepfour';
    case 5:
      return 'appstepfive';
    case 6:
      return 'appstepsix';
    case 7:
      return 'appstepseven';
    case 8:
      return 'appstepeight';
    case 9:
      return 'appstepnine';
    case 10:
      return 'appstepten';
    case 11:
      return 'appstepeleven';
    case 12:
      return 'appsteptwelve';
    case 13:
      return 'appstepthirteen';
    case 14:
      return 'appstepfourteen';
    case 15:
      return 'appstepfifteen';
    case 16:
      return 'appstepsixteen';
    case 32:
      return 'appstepseventeen';
    case 33:
      return 'appstepeighteen';

    default:
      return '';
  }
}
