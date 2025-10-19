package org.example;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/*")
public class FrontServlet extends HttpServlet {
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String requestUrl = req.getRequestURI();
        String method = req.getMethod();

        resp.setContentType("text/html");
        PrintWriter out = resp.getWriter();

        out.println("<html><body>");
        out.println("<h1>URL demandée : " + requestUrl + "</h1>");
        out.println("</body></html>");
    }
}