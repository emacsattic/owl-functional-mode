;;; owl-functional-mode.el --- Simple Emacs major mode for the OWL functional syntax
;;
;; Copyright (C) 2013  Vincent Akkermans
;;
;; Author: Vincent Akkermans <vincent@ack-err.net>
;;
;; This file is part of owl-functional-mode.el.
;;
;; owl-functional-mode.el is free software: you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation, either
;; version 3 of the License, or (at your option) any later version.
;;
;; owl-functional-mode.el is distributed in the hope that it will be
;; useful, but WITHOUT ANY WARRANTY; without even the implied
;; warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with owl-functional-mode.el. If not, see
;; http://www.gnu.org/licenses/.

(defvar owl-functional-mode-hook nil)

(defvar owlf-font-class-expression 'font-lock-function-name-face)
(defvar owlf-font-property 'font-lock-warning-face)
(defvar owlf-font-data-range 'font-lock-keyword-face)
(defvar owlf-font-axioms 'font-lock-type-face)
(defvar owlf-font-declarations 'font-lock-doc-face)
(defvar owlf-font-annotations 'font-lock-constant-face)
(defvar owlf-font-ontologies 'font-lock-variable-name-face)
(defvar owlf-font-uris 'font-lock-preprocessor-face)
(defvar owlf-font-prefix 'font-lock-comment-face)
(defvar owlf-font-literal 'font-lock-string-face)


(defvar owl-functional-font-lock-keywords
  `(
    ;;;; CLASSES

    ;; predefined
    (,(regexp-opt '("Thing"
                    "Nothing"
                    ) t)
     . ,owlf-font-class-expression)

    ;; class expressions - based on individuals and classes
    (,(regexp-opt '("ObjectIntersectionOf"
                    "ObjectUnionOf"
                    "ObjectComplementOf"
                    "ObjectOneOf"
                    "ObjectAllValuesFrom"
                    "ObjectSomeValuesFrom"
                    "ObjectHasValue"
                    "ObjectHasSelf"
                    "ObjectExactCardinality"
                    "ObjectMaxCardinality"
                    "ObjectMinCardinality"
                    ) t)
     . ,owlf-font-class-expression)

    ;; class expressions - based on data
    (,(regexp-opt '("DataAllValuesFrom"
                    "DataSomeValuesFrom"
                    "DataHasValue"
                    "DataExactCardinality"
                    "DataMaxCardinality"
                    "DataMinCardinality"
                    ) t)
     . ,owlf-font-class-expression)

    ;;;; PROPERTIES

    ;; Object properties
    (,(regexp-opt '("topObjectProperty"
                    "bottomObjectProperty"
                    ) t)
     . font-lock-builtin-face)

    ;; Data properties
    (,(regexp-opt '("topDataProperty"
                    "bottomDataProperty"
                    ) t)
     . ,owlf-font-property)

    ;; Object Property constructors
    (,(regexp-opt '("ObjectInverseOf"
                    ) t)
     . ,owlf-font-property)



    ;;;; DATA RANGES

    ;; data range expressions
    (,(regexp-opt '("DataComplementOf"
                    "DataIntersectionOf"
                    "DataUnionOf"
                    "DataOneOf"
                    "DatatypeRestriction") t)
     . ,owlf-font-data-range)



    ;;;; AXIOMS

    ;; class expression axioms
    (,(regexp-opt '("SubClassOf"
                    "EquivalentClasses"
                    "DisjointClasses"
                    "DisjointUnion") t)
     . ,owlf-font-axioms)

    ;; object property axioms
    (,(regexp-opt '("SubObjectPropertyOf"
                    "ObjectPropertyDomain"
                    "ObjectPropertyRange"
                    "EquivalentObjectProperties"
                    "DisjointObjectProperties"
                    "InverseObjectProperties"
                    "FunctionalObjectProperty"
                    "InverseFunctionalObjectProperty"
                    "ReflexiveObjectProperty"
                    "IrreflexiveObjectProperty"
                    "SymmetricObjectProperty"
                    "AsymmetricObjectProperty"
                    "TransitiveObjectProperty") t)
     . ,owlf-font-axioms)

    ;; data property axioms
    (,(regexp-opt '("SubDataPropertyOf"
                    "DataPropertyDomain"
                    "DataPropertyRange"
                    "EquivalentDataProperties"
                    "DisjointDataProperties"
                    "FunctionalDataProperty") t)
     . ,owlf-font-axioms)

    ;; datatype definitions
    (,(regexp-opt '("DatatypeDefinition") t)
     . ,owlf-font-axioms)

    ;; assertions
    (,(regexp-opt '("SameIndividual"
                    "DifferentIndividuals"
                    "ClassAssertion"
                    "ObjectPropertyAssertion"
                    "DataPropertyAssertion"
                    "NegativeObjectPropertyAssertion"
                    "NegativeDataPropertyAssertion"
                    "AnnotationAssertion"
                    ) t)
     . ,owlf-font-axioms)

    ;; keys
    (,(regexp-opt '("HasKey") t)
     . ,owlf-font-axioms)


    ;;;; DECLARATIONS

    (,(regexp-opt '("Declaration"
                    "Class"
                    "Datatype"
                    "ObjectProperty"
                    "DataProperty"
                    "AnnotationProperty"
                    "NamedIndividual"
                    ) t)
     . ,owlf-font-declarations)


    ;;;; ANNOTATIONS

    ;; annotations
    (,(regexp-opt '("AnnotationAssertion"
                    "Annotation")
                  t)
     . ,owlf-font-annotations)

    ;; annotation properties
    (,(regexp-opt '("label"
                    "comment"
                    "seeAlso"
                    "isDefinedBy"
                    "versionInfo"
                    "deprecated"
                    "backwardCompatibleWith"
                    "incompatibleWith"
                    "priorVersion") t)
     . ,owlf-font-annotations)

    ;; annotation axioms
    (,(regexp-opt '("SubAnnotationPropertyOf"
                    "AnnotationPropertyDomain"
                    "AnnotationPropertyRange") t)
     . ,owlf-font-annotations)

    ;;;; ONTOLOGIES

    (,(regexp-opt '("Ontology"
                    "Import"
                    "Prefix")
                  t)
     . ,owlf-font-ontologies)


    ;;;; FULL URIS

    ("<\\(.+\\)>" . ,owlf-font-uris)


    ;;;; PREFIXES

    ("\\(\\w*\\):" . ,owlf-font-prefix)


    ;;;; LITERALS

    ("\"\\(\\.+\\)\"" . ,owlf-font-literal)

    )
  "Minimal highlighting expressions for OWL Functional Syntax mode")


(define-derived-mode owl-functional-mode fundamental-mode "OWLFunc"
  "Major mode for editing OWL Functional Syntax files"
  (setq font-lock-defaults '(owl-functional-font-lock-keywords)))


(provide 'owl-functional-mode)
