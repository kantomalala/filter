package test.urlAnnotations;
import java.lang.reflect.Method;

import framework.annotations.*;


public class Main {
    public static void main(String[] args) {
        Class<UrlController> contUrl = UrlController.class;
        Method[] listMethode = contUrl.getDeclaredMethods();
        for (Method m : listMethode) {
            System.out.println("====================================================================");
            if (m.isAnnotationPresent(Url.class)) {
                Url url = m.getAnnotation(Url.class);
                System.out.println("Methode : " + m.getName());
                System.out.println("Url : " + url.value());
            } else {
                System.out.println("Methode : " + m.getName());
            }
        }
    }
}
