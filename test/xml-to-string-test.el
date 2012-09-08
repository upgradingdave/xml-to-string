;;;; xml-to-string-test.el --- ert tests for xml-to-string

(ert-deftest xml-to-string-test-parse-attr-list ()
  (let ((input '((class . "red") (id . "content"))))
    (should (equal "class=\"red\" id=\"content\"" 
                   (xml-to-string-parse-attr-list input)))))

(ert-deftest xml-to-string-test-parse-qname ()
  (let ((input "simple"))
    (should (equal input (xml-to-string-parse-qname input)))))

(ert-deftest xml-to-string-test-parse-node ()
  (let ((input '(dependency nil "\n        "
                            (groupId ((class . "red") (id . "content")) "org.eclipse.jetty")
                            "\n        "
                            (artifactId nil "jetty-servlet")
                            "\n        "
                            (version nil "${jetty.version}")
                            "\n      "))
        (expected "<dependency>\n        <groupId class=\"red\" id=\"content\">org.eclipse.jetty</groupId>\n        <artifactId>jetty-servlet</artifactId>\n        <version>${jetty.version}</version>\n      </dependency>"))
    (should (equal expected (xml-to-string-parse-node input)))))

(ert-deftest xml-to-string-test-parse-child-node-list ()
  (let ((input '((dependency nil "\n        "
                             (groupId nil "org.eclipse.jetty")
                             "\n        "
                             (artifactId nil "jetty-servlet")
                             "\n        "
                             (version nil "${jetty.version}")
                             "\n      ")
                 (dependency nil "\n	"
                             (groupId nil "jstl")
                             "\n	"
                             (artifactId nil "jstl")
                             "\n	"
                             (version nil "${jstl.version}")
                             "\n      ")))
        (expected "<dependency>\n        <groupId>org.eclipse.jetty</groupId>\n        <artifactId>jetty-servlet</artifactId>\n        <version>${jetty.version}</version>\n      </dependency><dependency>\n	<groupId>jstl</groupId>\n	<artifactId>jstl</artifactId>\n	<version>${jstl.version}</version>\n      </dependency>"))
    (should (equal expected (xml-to-string-parse-child-node-list input)))))

