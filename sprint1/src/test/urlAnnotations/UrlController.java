package test.urlAnnotations;

import framework.annotations.*;

public class UrlController {
    @Url("/test1")
    public void sayHello() {
        System.out.println("C'est un test de salutation");
    }

    @Url("/test2")
    public void sayBye() {
        System.out.println("C'est un test d'au revoir");
    }

    @Url("/test3")
    public void sayThanks(){
        System.out.println("C'est un test de remerciement");
    }

    public void sayHi() {}

}
