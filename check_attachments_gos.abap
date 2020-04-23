*&---------------------------------------------------------------------*
*&      Form  VLTE_ADJUNTOS
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*
FORM vlte_adjuntos .

* business object key
  DATA: gs_lpor TYPE sibflporb .
*
  gs_lpor-instid = gst_solpre-solpre .
  gs_lpor-typeid = c_objtype.
  gs_lpor-catid  = c_catid.
*
* attachment type selection
  DATA: lt_relat TYPE obl_t_relt,
        la_relat LIKE LINE OF lt_relat.
*
  la_relat-sign = 'I'.
  la_relat-option = 'EQ'.
  la_relat-low = 'ATTA' .
  APPEND la_relat TO lt_relat .

* Read the links
  DATA: t_links  TYPE obl_t_link,
        la_links LIKE LINE OF t_links.

  DATA: lo_root TYPE REF TO cx_root .

  " Lee los documentos anexos.
  TRY .

      CALL METHOD cl_binary_relation=>read_links
        EXPORTING
          is_object           = gs_lpor
          it_relation_options = lt_relat
        IMPORTING
          et_links            = t_links.

      IF t_links[] IS INITIAL .
        MESSAGE e005(zwf) .
      ENDIF.

    CATCH cx_root INTO lo_root .
      MESSAGE e004(zwf) .
  ENDTRY .

ENDFORM.                    " VLTE_ADJUNTOS
