class CA {
  int[] cells;
  int[] ruleset;
  int w = 8;
  int complex = 8;
  // The CA should keep track of how
  // many generations.
  int generation = 0;
  CA() {
    cells = new int[width/w];
    ruleset = randomRules();
    cells[cells.length/2] = 1;
  }

  // Function to compute the next generation
  void generate() {
    int[] nextgen = new int[cells.length];
    for (int i = 1; i < cells.length-1; i++) {
      int left   = cells[i-1];
      int me     = cells[i];
      int right  = cells[i+1];
      nextgen[i] = rules(left, me, right);
    }
    cells = nextgen;
    // Increment the generation counter.
    generation++;

    if(generation*w > height) {
      generation = 0;
      ruleset = randomRules();
    }

    for (int i = 0; i < cells.length; i++) {
      if (cells[i] == 1) fill(0);
      else               fill(255);
      // Set the y-location according to the generation.
      ellipse(i*w, generation*w, w, w);
    }
  }

  int[] randomRules() {
    int[] newrules = new int[complex];

    for (int i = 0; i < complex; ++i) {
      newrules[i] = int(random(2));
    }

    return newrules;
  }

  int rules(int a, int b, int c) {
    String s = "" + a + b + c;
    int index = Integer.parseInt(s,2);
    return ruleset[index];
  }
}