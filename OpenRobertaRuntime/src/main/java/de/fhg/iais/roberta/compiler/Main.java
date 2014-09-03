package de.fhg.iais.roberta.compiler;

import lejos.utility.Delay;
import de.fhg.iais.roberta.ast.syntax.BrickConfiguration;
import de.fhg.iais.roberta.codegen.lejos.Hal;

public class Main {
    private static final BrickConfiguration brickConfiguration = new BrickConfiguration.Builder().build();

    public static void main(String[] args) {
        Main.run();
    }

    public static void run() {
        Hal hal = new Hal(brickConfiguration);
        hal.drawText("Hallo", 0, 3);
        Delay.msDelay(3000);
    }
}