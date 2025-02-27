# frozen_string_literal: true

# require 'active_support/inflector'

# rubocop:disable Layout/LineLength

module MyDATA
  module Constants
    BY_CATEGORY = {
      measurement_unit: {
        pieces: {
          value: 1,
          description: {
            en: 'pieces',
            el: 'Τεμάχια' }
        },
        kg: {
          value: 2,
          description: {
            en: 'kg',
            el: 'Κιλά' }
        },
        litres: {
          value: 3,
          description: {
            en: 'litres',
            el: 'Λίτρα' }
        },
        meters: {
          value: 4,
          description: {
            en: 'meters',
            el: 'Μέτρα' }
        },
        square_meters: {
          value: 5,
          description: {
            en: 'square meters', el:
            'Τετραγωνικά μέτρα' }
        },
        cubic_meters: {
          value: 6,
          description: {
            en: 'cubic meters',
            el: 'Κυβικά μέτρα' },
        },
        pieces_other: {
          value: 7,
          description: {
            en: 'pieces other cases',
            el: 'Τεμάχια_Λοιπές Περιπτώσεις' }
        },
      },
      payment_type: {
        domestic_payments_account_number: {
          value: 1,
          description: {
            en: 'Domestic Payments Account Number',
            el: 'Επαγ. Λογαριασμός Πληρωμών Ημεδαπής' },
        },
        foreign_payments_account_number: {
          value: 2,
          description: {
            en: 'Foreign Payments Account Number',
            el: 'Επαγ. Λογαριασμός Πληρωμών Αλλοδαπής' },
        },
        cash: {
          value: 3,
          description: {
            en: 'Cash',
            el: 'Μετρητά' },
        },
        check: {
          value: 4,
          description: {
            en: 'Check',
            el: 'Επιταγή' },
        },
        on_credit: {
          value: 5,
          description: {
            en: 'On credit',
            el: 'Πίστωση' },
        },
        web_banking: {
          value: 6,
          description: {
            en: 'Web Banking',
            el: 'Web Banking' },
        },
        pos: {
          value: 7,
          description: {
            en: 'POS/e-POS',
            el: 'POS/e-POS' },
        },
        iris: {
          value: 8,
          description: {
            en: 'IRIS Immediate Payments',
            el: 'Άμεσες Πληρωμές IRIS' },
        }
      },
      invoice_type: {
        sales_invoice: {
          value: '1.1',
          description: {
            en: 'Sales Invoice',
            el: 'Τιμολόγιο Πώλησης' },
        },
        intra_community_sales_invoice: {
          value: '1.2',
          description: {
            en: 'Sales Invoice/Intra-community Supplies',
            el: 'Τιμολόγιο Πώλησης/Ενδοκοινοτικές Παραδόσεις' },
        },
        third_country_sales_invoice: {
          value: '1.3',
          description: {
            en: 'Sales Invoice/Third Country Supplies',
            el: 'Τιμολόγιο Πώλησης/Παραδόσεις Τρίτων Χωρών' },
        },
        sale_on_behalf_of_third_parties_sales_invoice: {
          value: '1.4',
          description: {
            en: 'Sales Invoice/Sale on Behalf of Third Parties',
            el: 'Τιμολόγιο Πώλησης/Πώληση για Λογαριασμό Τρίτων' },
        },
        clearance_or_fees_on_behalf_of_third_parties_sales_invoice: {
          value: '1.5',
          description: {
            en: 'Sales Invoice/Clearance of Sales on Behalf of Third Parties – Fees from Sales on Behalf of Third Parties',
            el: 'Τιμολόγιο Πώλησης / Εκκαθάριση Πωλήσεων Τρίτων - Αμοιβή από Πωλήσεις Τρίτων' },
        },
        supplemental_accounting_source_document_sales_invoice: {
          value: '1.6',
          description: {
            en: 'Sales Invoice/Supplemental Accounting Source Document',
            el: 'Τιμολόγιο Πώλησης/Συμπληρωματικό Παραστατικό' },
        },
        service_invoice: {
          value: '2.1',
          description: {
            en: 'Service Rendered Invoice',
            el: 'Τιμολόγιο Παροχής' },
        },
        intra_community_service_invoice: {
          value: '2.2',
          description: {
            en: 'Intra-community Service Rendered Invoice',
            el: 'Τιμολόγιο Παροχής / Ενδοκοινοτική Παροχή Υπηρεσιών' },
        },
        third_country_service_invoice: {
          value: '2.3',
          description: {
            en: 'Third Country Service Rendered Invoice',
            el: 'Τιμολόγιο Παροχής / Παροχή Υπηρεσιών σε λήπτη Τρίτης Χώρας' },
        },
        service_invoice_supplemental_accounting_source_document: {
          value: '2.4',
          description: {
            en: 'Service Rendered Invoice/Supplemental Accounting Source Document',
            el: 'Τιμολόγιο Παροχής/Συμπληρωματικό Παραστατικό' },
        },
        proof_of_expenditure_non_liable_issuer: {
          value: '3.1',
          description: {
            en: 'Proof of Expenditure (non-liable Issuer)',
            el: 'Τίτλος Κτήσης (μη υπόχρεος Εκδότης)' },
        },
        proof_of_expenditure_denial_of_issuance: {
          value: '3.2',
          description: {
            en: 'Proof of Expenditure (denial of issuance by liable Issuer)',
            el: 'Τίτλος Κτήσης (αρνητική έκδοση υπόχρεου Εκδότη)' },
        },
        credit_invoice_associated: {
          value: '5.1',
          description: {
            en: 'Credit Invoice/Associated',
            el: 'Πιστωτικό Τιμολόγιο/Συνδεδεμένο' },
        },
        credit_invoice_non_associated: {
          value: '5.2',
          description: {
            en: 'Credit Invoice/Non-Associated',
            el: 'Πιστωτικό Τιμολόγιο/Μη Συνδεδεμένο' },
        },
        self_delivery_record: {
          value: '6.1',
          description: {
            en: 'Self-Delivery Record',
            el: 'Στοιχείο Αυτοπαράδοσης' },
        },
        self_supply_record: {
          value: '6.2',
          description: {
            en: 'Self-Supply Record',
            el: 'Στοιχείο Ιδιοχρησιμοποίησης' },
        },
        contract_income: {
          value: '7.1',
          description: {
            en: 'Contract – Income',
            el: 'Συμβόλαιο - Έσοδο' },
        },
        rents_income: {
          value: '8.1',
          description: {
            en: 'Rents – Income',
            el: 'Ενοίκια - Έσοδο' },
        },
        climate_crisis_resilience_fee: {
          value: '8.2',
          description: {
            en: 'Climate Crisis Resilience Fee',
            el: 'Τέλος ανθεκτικότητας κλιματικής κρίσης' },
        },
        receipt_of_payment_pos: {
          value: '8.4',
          description: {
            en: 'Receipt of Payment POS',
            el: 'Απόδειξη Είσπραξης POS' },
        },
        return_receipt_pos: {
          value: '8.5',
          description: {
            en: 'Return Receipt POS',
            el: 'Απόδειξη Επιστροφής POS' },
        },
        purchase_order: {
          value: '8.6',
          description: {
            en: 'Focused Purchase Order',
            el: 'Δελτίο Παραγγελίας Εστίασης' },
        },
        dispatch_note: {
          value: '9.3',
          description: {
            en: 'Dispatch Note',
            el: 'Δελτίο Αποστολής' },
        },
        retail_sales_receipt: {
          value: '11.1',
          description: {
            en: 'Retail Sales Receipt',
            el: 'Απόδειξη Λιανικής Πώλησης' },
        },
        service_rendered_receipt: {
          value: '11.2',
          description: {
            en: 'Service Rendered Receipt',
            el: 'Απόδειξη Παροχής Υπηρεσίας' },
        },
        simplified_invoice: {
          value: '11.3',
          description: {
            en: 'Simplified Invoice',
            el: 'Απλοποιημένο Τιμολόγιο' },
        },
        retail_sales_credit_note: {
          value: '11.4',
          description: {
            en: 'Retail Sales Credit Note',
            el: 'Πιστωτικό Στοιχ. Λιανικής' },
        },
        retail_sales_receipt_on_behalf_of_third_parties: {
          value: '11.5',
          description: {
            en: 'Retail Sales Receipt on Behalf of Third Parties',
            el: 'Απόδειξη Λιανικής Πώλησης για Λογαριασμό Τρίτων' },
        },
        expense_domestic_foreign_retail_transaction_purchases: {
          value: '13.1',
          description: {
            en: 'Expenses – Domestic/Foreign Retail Transaction Purchases',
            el: 'Έξοδα - Αγορές Λιανικών Συναλλαγών ημεδαπής / αλλοδαπής' },
        },
        domestic_foreign_retail_transaction_provision: {
          value: '13.2',
          description: {
            en: 'Domestic/Foreign Retail Transaction Provision',
            el: 'Παροχή Λιανικών Συναλλαγών ημεδαπής / αλλοδαπής' },
        },
        shared_utility_bills: {
          value: '13.3',
          description: {
            en: 'Shared Utility Bills',
            el: 'Κοινόχρηστα' },
        },
        subscriptions: {
          value: '13.4',
          description: {
            en: 'Subscriptions',
            el: 'Συνδρομές' },
        },
        retail_self_declared_entity_accounting_source_documents: {
          value: '13.30',
          description: {
            en: 'Self-Declared Entity Accounting Source Documents (Dynamic)',
            el: 'Παραστατικά Οντότητας ως Αναγράφονται από την ίδια (Δυναμικό)' },
        },
        domestic_foreign_retail_sales_credit_note: {
          value: '13.31',
          description: {
            en: 'Domestic/Foreign Retail Sales Credit Note',
            el: 'Πιστωτικό Στοιχ. Λιανικής ημεδαπής / αλλοδαπής' },
        },
        invoice_intra_community_acquisitions: {
          value: '14.1',
          description: {
            en: 'Invoice/Intra-community Acquisitions',
            el: 'Τιμολόγιο/Ενδοκοινοτικές Αποκτήσεις' },
        },
        invoice_third_country_acquisitions: {
          value: '14.2',
          description: {
            en: 'Invoice/Third Country Acquisitions',
            el: 'Τιμολόγιο/Αποκτήσεις Τρίτων Χωρών' },
        },
        invoice_intra_community_services_receipt: {
          value: '14.3',
          description: {
            en: 'Invoice/Intra-community Services Receipt',
            el: 'Τιμολόγιο/Ενδοκοινοτική Λήψη Υπηρεσιών' },
        },
        invoice_third_country_services_receipt: {
          value: '14.4',
          description: {
            en: 'Invoice/Third Country Services Receipt',
            el: 'Τιμολόγιο/Λήψη Υπηρεσιών σε λήπτη Τρίτης Χώρας' },
        },
        efka: {
          value: '14.5',
          description: {
            en: 'EFKA',
            el: 'ΕΦΚΑ και λοιποί Ασφαλιστικοί Οργανισμοί' },
        },
        self_declared_entity_accounting_source_documents: {
          value: '14.30',
          description: {
            en: 'Self-Declared Entity Accounting Source Documents (Dynamic)',
            el: 'Παραστατικά Οντότητας ως Αναγράφονται από την ίδια (Δυναμικό)' },
        },
        domestic_foreign_credit_note: {
          value: '14.31',
          description: {
            en: 'Domestic/Foreign Credit Note',
            el: 'Πιστωτικό ημεδαπής / αλλοδαπής' },
        },
        contract_expense: {
          value: '15.1',
          description: {
            en: 'Contract-Expense',
            el: 'Συμβόλαιο-Έξοδο' },
        },
        rent_expense: {
          value: '16.1',
          description: {
            en: 'Rent-Expense',
            el: 'Ενοίκιο-Έξοδο' },
        },
        payroll: {
          value: '17.1',
          description: {
            en: 'Payroll',
            el: 'Μισθοδοσία' },
        },
        amortisations: {
          value: '17.2',
          description: {
            en: 'Amortisations',
            el: 'Αποσβέσεις' },
        },
        other_income_adjustment_entries_accounting_base: {
          value: '17.3',
          description: {
            en: 'Other Income Adjustment/Regularisation Entries – Accounting Base',
            el: 'Λοιπές Εγγραφές Τακτοποίησης Εσόδων - Λογιστική Βάση' },
        },
        other_income_adjustment_entries_tax_base: {
          value: '17.4',
          description: {
            en: 'Other Income Adjustment/Regularisation Entries – Tax Base',
            el: 'Λοιπές Εγγραφές Τακτοποίησης Εσόδων - Φορολογική Βάση' },
        },
        other_expense_adjustment_entries_accounting_base: {
          value: '17.5',
          description: {
            en: 'Other Expense Adjustment/Regularisation Entries – Accounting Base',
            el: 'Λοιπές Εγγραφές Τακτοποίησης Εξόδων - Λογιστική Βάση' },
        },
      },
      vat_category: {
        regular_vat_rate: {
          value: 1,
          description: {
            en: 'VAT rate 24%',
            el: 'ΦΠΑ συντελεστής 24%' },
        },
        reduced_vat_rate: {
          value: 2,
          description: {
            en: 'VAT rate 13%',
            el: 'ΦΠΑ συντελεστής 13%' },
        },
        super_reduced_vat_rate: {
          value: 3,
          description: {
            en: 'VAT rate 6%',
            el: 'ΦΠΑ συντελεστής 6%' },
        },
        local_regular_vat_rate: {
          value: 4,
          description: {
            en: 'VAT rate 17%',
            el: 'ΦΠΑ συντελεστής 17%' },
        },
        local_reduced_vat_rate: {
          value: 5,
          description: {
            en: 'VAT rate 9%',
            el: 'ΦΠΑ συντελεστής 9%' },
        },
        local_super_reduced_vat_rate: {
          value: 6,
          description: {
            en: 'VAT rate 4%',
            el: 'ΦΠΑ συντελεστής 4%' },
        },
        without_vat: {
          value: 7,
          description: {
            en: 'Without VAT',
            el: 'Άνευ Φ.Π.Α' },
        },
        records_without_vat: {
          value: 8,
          description: {
            en: 'Records without VAT (e.g. Payroll, Amortisations)',
            el: 'Εγγραφές Χωρίς ΦΠΑ (π.χ. Μισθοδοσία, Αποσβέσεις)' },
        },
        vat_code_9: {
          value: 9,
          description: {
            en: 'VAT rate 3% (art.31 n.5057/2023)',
            el: 'ΦΠΑ συντελεστής 3% (αρ.31 ν.5057/2023)' },
        },
        vat_code_10: {
          value: 10,
          description: {
            en: 'VAT rate 4% (art.31 n.5057/2023)',
            el: 'ΦΠΑ συντελεστής 4% (αρ.31 ν.5057/2023)' },
        }
      },
      vat_exemption_category: {
        without_vat_article_2_and_3: {
          value: 1,
          description: {
            en: 'Without VAT - article 2 and 3 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 2 και 3 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_5: {
          value: 2,
          description: {
            en: 'Without VAT - article 5 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 5 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_13: {
          value: 3,
          description: {
            en: 'Without VAT - article 13 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 13 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_14: {
          value: 4,
          description: {
            en: 'Without VAT - article 14 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 14 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_16: {
          value: 5,
          description: {
            en: 'Without VAT - article 16 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 16 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_19: {
          value: 6,
          description: {
            en: 'Without VAT - article 19 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 19 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_22: {
          value: 7,
          description: {
            en: 'Without VAT - article 22 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 22 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_24: {
          value: 8,
          description: {
            en: 'Without VAT - article 24 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 24 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_25: {
          value: 9,
          description: {
            en: 'Without VAT - article 25 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 25 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_26: {
          value: 10,
          description: {
            en: 'Without VAT - article 26 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 26 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_27: {
          value: 11,
          description: {
            en: 'Without VAT - article 27 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 27 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_27_seagoing_vessels: {
          value: 12,
          description: {
            en: 'Without VAT - article 27 - Seagoing Vessels of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 27 - - Πλοία Ανοικτής Θαλάσσης του Κώδικα ΦΠΑ' },
        },
        without_vat_article_27_1_γ_seagoing_vessels: {
          value: 13,
          description: {
            en: 'Without VAT - article 27.1.γ - Seagoing Vessels of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 27.1.γ - Πλοία Ανοικτής Θαλάσσης του Κώδικα ΦΠΑ' },
        },
        without_vat_article_28: {
          value: 14,
          description: {
            en: 'Without VAT - article 28 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 28 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_39: {
          value: 15,
          description: {
            en: 'Without VAT - article 39 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 39 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_39a: {
          value: 16,
          description: {
            en: 'Without VAT - article 39a of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 39α του Κώδικα ΦΠΑ' },
        },
        without_vat_article_40: {
          value: 17,
          description: {
            en: 'Without VAT - article 40 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 40 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_41: {
          value: 18,
          description: {
            en: 'Without VAT - article 41 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 41 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_47: {
          value: 19,
          description: {
            en: 'Without VAT - article 47 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 47 του Κώδικα ΦΠΑ' },
        },
        vat_included_article_43: {
          value: 20,
          description: {
            en: 'VAT included - article 43 of the VAT code',
            el: 'ΦΠΑ συμπεριλαμβανόμενος – άρθρο 43 του Κώδικα ΦΠΑ' },
        },
        vat_included_article_44: {
          value: 21,
          description: {
            en: 'VAT included - article 44 of the VAT code',
            el: 'ΦΠΑ συμπεριλαμβανόμενος – άρθρο 44 του Κώδικα ΦΠΑ' },
        },
        vat_included_article_45: {
          value: 22,
          description: {
            en: 'VAT included - article 45 of the VAT code',
            el: 'ΦΠΑ συμπεριλαμβανόμενος – άρθρο 45 του Κώδικα ΦΠΑ' },
        },
        vat_included_article_46: {
          value: 23,
          description: {
            en: 'VAT included - article 46 of the VAT code',
            el: 'ΦΠΑ συμπεριλαμβανόμενος – άρθρο 46 του Κώδικα ΦΠΑ' },
        },
        without_vat_article_6: {
          value: 24,
          description: {
            en: 'Without VAT - article 6 of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 6 του Κώδικα ΦΠΑ' },
        },
        without_vat_pol_1029_1995: {
          value: 25,
          description: {
            en: 'Without VAT - POL 1029/1995',
            el: 'Χωρίς ΦΠΑ – ΠΟΛ 1029/1995' },
        },
        without_vat_pol_1067_2015: {
          value: 26,
          description: {
            en: 'Without VAT - POL 1067/2015',
            el: 'Χωρίς ΦΠΑ – ΠΟΛ 1067/2015' },
        },
        without_vat_other: {
          value: 27,
          description: {
            en: 'Without VAT - Other VAT exceptions',
            el: 'Λοιπές Εξαιρέσεις ΦΠΑ' },
        },
        without_vat_article_24_b_1: {
          value: 28,
          description: {
            en: 'Without VAT - article 24 (b) (1) of the VAT code',
            el: 'Χωρίς ΦΠΑ – άρθρο 24 περ. β\' παρ.1 του Κώδικα ΦΠΑ, (Tax Free)' },
        },
        without_vat_article_47_b: {
          value: 29,
          description: {
            en: 'Without VAT - Article 47b of the VAT Code (OSS non-EU scheme)',
            el: 'Χωρίς ΦΠΑ – άρθρο 47β, του Κώδικα ΦΠΑ (OSS μη ενωσιακό καθεστώς)' },
        },
        without_vat_article_47_c: {
          value: 30,
          description: {
            en: 'Without VAT - Article 47c of the VAT Code (OSS EU scheme)',
            el: 'Χωρίς ΦΠΑ – άρθρο 47γ, του Κώδικα ΦΠΑ (OSS ενωσιακό καθεστώς)' },
        },
        without_vat_article_47_d: {
          value: 31,
          description: {
            en: 'Without VAT - Article 47d of the VAT Code (IOSS)',
            el: 'Χωρίς ΦΠΑ – άρθρο 47δ, του Κώδικα ΦΠΑ (IOSS)' },
        }
      },
      income_classification_category: {
        community_sales: {
          value: 'category1_1',
          description: {
            en: 'Commodity Sale Income',
            el: 'Έσοδα από Πώληση Εμπορευμάτων' },
        },
        category1_2: {
          value: 'category1_2',
          description: {
            en: 'Product Sale Income',
            el: 'Έσοδα από Πώληση Προϊόντων' },
        },
        category1_3: {
          value: 'category1_3',
          description: {
            en: 'Provision of Services Income',
            el: 'Έσοδα από Παροχή Υπηρεσιών' },
        },
        category1_4: {
          value: 'category1_4',
          description: {
            en: 'Sale of Fixed Assets Income',
            el: 'Έσοδα από Πώληση Μεταβιβαζόμενων Ακινήτων' },
        },
        category1_5: {
          value: 'category1_5',
          description: {
            en: 'Other Income/Profits',
            el: 'Λοιπά Έσοδα/ Κέρδη' },
        },
        category1_6: {
          value: 'category1_6',
          description: {
            en: 'Self-Deliveries/Self-Supplies',
            el: 'Αυτοπαραδόσεις / Ιδιοχρησιμοποιήσεις' },
        },
        category1_7: {
          value: 'category1_7',
          description: {
            en: 'Income on behalf of Third Parties',
            el: 'Έσοδα για Λογαριασμό Τρίτων' },
        },
        category1_8: {
          value: 'category1_8',
          description: {
            en: 'Past fiscal years income',
            el: 'Έσοδα προηγούμενων χρήσεων' },
        },
        category1_9: {
          value: 'category1_9',
          description: {
            en: 'Future fiscal years income',
            el: 'Έσοδα επερχόμενων χρήσεων' },
        },
        category1_10: {
          value: 'category1_10',
          description: {
            en: 'Other Income Adjustment/Regularisation Entries',
            el: 'Λοιπές Εγγραφές Τακτοποίησης Εσόδων' },
        },
        category1_95: {
          value: 'category1_95',
          description: {
            en: 'Other Income-related Information',
            el: 'Λοιπά Πληροφοριακά Στοιχεία Εσόδων' },
        },
        category3: {
          value: 'category3',
          description: {
            en: 'Delivery',
            el: 'Διακίνηση' },
        },
      },
      income_classification_type: {
        E3_106_income: {
          value: 'E3_106',
          description: {
            en: 'Self-Production of Fixed Assets – Self-Deliveries – Destroying inventory/Commodities',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων/Εμπορεύματα' },
        },
        E3_205_income: {
          value: 'E3_205',
          description: {
            en: 'Self-Production of Fixed Assets – Self-Deliveries – Destroying inventory/Raw and other materials',
            el: 'Ιδιοπαραγωγή παγίων - Καταστροφές αποθεμάτων/Πρώτες ύλες και λοιπά υλικά' },
        },
        E3_210_income: {
          value: 'E3_210',
          description: {
            en: 'Self-Production of Fixed Assets – Self-Deliveries – Destroying inventory/Products and production in progress',
            el: 'Ιδιοπαραγωγή παγίων - Καταστροφές αποθεμάτων/Προϊόντα και παραγωγή σε εξέλιξη' },
        },
        E3_305_income: {
          value: 'E3_305',
          description: {
            en: 'Self-Production of Fixed Assets – Self-Deliveries – Destroying inventory/Raw and other materials',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων/Πρώτες ύλες και λοιπά υλικά' },
        },
        E3_310_income: {
          value: 'E3_310',
          description: {
            en: 'Self-Production of Fixed Assets – Self-Deliveries – Destroying inventory/Products and production in progress',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων/Προϊόντα και παραγωγή σε εξέλιξη' },
        },
        E3_318_income: {
          value: 'E3_318',
          description: {
            en: 'Self-Production of Fixed Assets – Self-Deliveries – Destroying inventory/Production expenses',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων/Έξοδα παραγωγής' },
        },
        E3_561_001_income: {
          value: 'E3_561_001',
          description: {
            en: 'Wholesale Sales of Goods and Services – for Traders',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Χονδρικές - Επιτηδευματιών' },
        },
        E3_561_002_income: {
          value: 'E3_561_002',
          description: {
            en: 'Wholesale Sales of Goods and Services pursuant to article 39a paragraph 5 of the VAT Code (Law 2859/2000)',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Χονδρικές βάσει άρθρου 39α παρ 5 του Κώδικα Φ.Π.Α. (Ν.2859/2000)' },
        },
        E3_561_003_income: {
          value: 'E3_561_003',
          description: {
            en: 'Retail Sales of Goods and Services – Private Clientele',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Λιανικές - Ιδιωτική Πελατεία' },
        },
        E3_561_004_income: {
          value: 'E3_561_004',
          description: {
            en: 'Retail Sales of Goods and Services pursuant to article 39a paragraph 5 of the VAT Code (Law 2859/2000)',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Λιανικές βάσει άρθρου 39α παρ 5 του Κώδικα Φ.Π.Α. (Ν.2859/2000)' },
        },
        E3_561_005_income: {
          value: 'E3_561_005',
          description: {
            en: 'Intra-Community Foreign Sales of Goods and Services',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_561_006_income: {
          value: 'E3_561_006',
          description: {
            en: 'Third Country Foreign Sales of Goods and Services',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Εξωτερικού Τρίτες Χώρες' },
        },
        E3_561_007_income: {
          value: 'E3_561_007',
          description: {
            en: 'Other Sales of Goods and Services',
            el: 'Πωλήσεις αγαθών και υπηρεσιών Λοιπά' },
        },
        E3_562_income: {
          value: 'E3_562',
          description: {
            en: 'Other Ordinary Income',
            el: 'Λοιπά συνήθη έσοδα' },
        },
        E3_563_income: {
          value: 'E3_563',
          description: {
            en: 'Credit Interest and Related Income',
            el: 'Πιστωτικοί τόκοι και συναφή έσοδα' },
        },
        E3_564_income: {
          value: 'E3_564',
          description: {
            en: 'Credit Exchange Differences',
            el: 'Πιστωτικές συναλλαγματικές διαφορές' },
        },
        E3_565_income: {
          value: 'E3_565',
          description: {
            en: 'Income from Participations',
            el: 'Έσοδα Έσοδα συμμετοχών' },
        },
        E3_566_income: {
          value: 'E3_566',
          description: {
            en: 'Κέρδη από διάθεση μη κυκλοφορούντων περιουσιακών στοιχείων',
            el: 'Profits from Disposing Non-Current Assets' },
        },
        E3_567_income: {
          value: 'E3_567',
          description: {
            el: 'Κέρδη από αναστροφή προβλέψεων και απομειώσεων',
            en: 'Profits from the Reversal of Provisions and Impairments' },
        },
        E3_568_income: {
          value: 'E3_568',
          description: {
            en: 'Profits from Measurement at Fair Value',
            el: 'Κέρδη από επιμέτρηση στην εύλογη αξία' },
        },
        E3_570_income: {
          value: 'E3_570',
          description: {
            en: 'Extraordinary income and profits',
            el: 'Ασυνήθη έσοδα και κέρδη' },
        },
        E3_595_income: {
          value: 'E3_595',
          description: {
            en: 'Self-Production Expenses',
            el: 'Έξοδα σε ιδιοπαραγωγή' },
        },
        E3_596_income: {
          value: 'E3_596',
          description: {
            en: 'Subsidies - Grants',
            el: 'Επιδοτήσεις - Επιχορηγήσεις' },
        },
        E3_597_income: {
          value: 'E3_597',
          description: {
            en: 'Subsidies – Grants for Investment Purposes – Expense Coverage',
            el: 'Επιδοτήσεις - Επιχορηγήσεις για επενδυτικούς σκοπούς - κάλυψη δαπανών' },
        },
        E3_880_001_income: {
          value: 'E3_880_001',
          description: {
            en: 'Wholesale Sales of Fixed Assets',
            el: 'Πωλήσεις Παγίων Χονδρικές' },
        },
        E3_880_002_income: {
          value: 'E3_880_002',
          description: {
            en: 'Retail Sales of Fixed Assets',
            el: 'Πωλήσεις Παγίων Λιανικές' },
        },
        E3_880_003_income: {
          value: 'E3_880_003',
          description: {
            en: 'Intra-Community Foreign Sales of Fixed Assets',
            el: 'Πωλήσεις Παγίων Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_880_004_income: {
          value: 'E3_880_004',
          description: {
            en: 'Third Country Foreign Sales of Fixed Assets',
            el: 'Πωλήσεις Παγίων Εξωτερικού Τρίτες Χώρες' },
        },
        E3_881_001_income: {
          value: 'E3_881_001',
          description: {
            en: 'Wholesale Sales on behalf of Third Parties',
            el: 'Πωλήσεις για λογαριασμό τρίτων Χονδρικές' },
        },
        E3_881_002_income: {
          value: 'E3_881_002',
          description: {
            en: 'Retail Sales on behalf of Third Parties',
            el: 'Πωλήσεις για λογαριασμό τρίτων Λιανικές' },
        },
        E3_881_003_income: {
          value: 'E3_881_003',
          description: {
            en: 'Intra-Community Foreign Sales on behalf of Third Parties',
            el: 'Πωλήσεις για λογαριασμό τρίτων Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_881_004_income: {
          value: 'E3_881_004',
          description: {
            en: 'Third Country Foreign Sales on behalf of Third Parties',
            el: 'Πωλήσεις για λογαριασμό τρίτων Εξωτερικού Τρίτες Χώρες' },
        },
        E3_598_001_income: {
          value: 'E3_598_001',
          description: {
            en: 'Sales of goods belonging to excise duty',
            el: 'Πωλήσεις αγαθών που υπάγονται σε ΕΦΚ' },
        },
        E3_598_003_income: {
          value: 'E3_598_003',
          description: {
            en: 'Sales on behalf of farmers through an agricultural cooperative etc.',
            el: 'Πωλήσεις για λογαριασμό αγροτών μέσω αγροτικού συνεταιρισμού κλπ' },
        }
      },
      expense_classification_category: {
        commodity_purchases: {
          value: 'category2_1',
          description: {
            en: 'Commodity Purchases',
            el: 'Αγορές Εμπορευμάτων' },
        },
        raw_and_adjuvant_material_purchases: {
          value: 'category2_2',
          description: {
            en: 'Raw and Adjuvant Material Purchases',
            el: 'Αγορές Α\'-Β\' Υλών' },
        },
        services_receipt: {
          value: 'category2_3',
          description: {
            en: 'Services Receipt',
            el: 'Λήψη Υπηρεσιών' },
        },
        general_expenses_subject_to_vat_deduction: {
          value: 'category2_4',
          description: {
            en: 'General Expenses Subject to VAT Deduction',
            el: 'Γενικά Έξοδα με δικαίωμα έκπτωσης ΦΠΑ' },
        },
        general_expenses_not_subject_to_vat_deduction: {
          value: 'category2_5',
          description: {
            en: 'General Expenses Not Subject to VAT Deduction',
            el: 'Γενικά Έξοδα χωρίς δικαίωμα έκπτωσης ΦΠΑ' },
        },
        personnel_fees_and_benefits: {
          value: 'category2_6',
          description: {
            en: 'Personnel Fees and Benefits',
            el: 'Αμοιβές και Επιδόματα Προσωπικού' },
        },
        fixed_asset_purchases: {
          value: 'category2_7',
          description: {
            en: 'Fixed Asset Purchases',
            el: 'Αγορές Παγίων' },
        },
        fixed_asset_amortisations: {
          value: 'category2_8',
          description: {
            en: 'Fixed Asset Amortisations',
            el: 'Αποσβέσεις Παγίων' },
        },
        expenses_on_behalf_of_third_parties: {
          value: 'category2_9',
          description: {
            en: 'Expenses on behalf of Third Parties',
            el: 'Έξοδα για λογαριασμό τρίτων' },
        },
        past_fiscal_years_expenses: {
          value: 'category2_10',
          description: {
            en: 'Past fiscal years expenses',
            el: 'Έξοδα προηγούμενων χρήσεων' },
        },
        future_fiscal_years_expenses: {
          value: 'category2_11',
          description: {
            en: 'Future fiscal years expenses',
            el: 'Έξοδα επομένων χρήσεων' },
        },
        other_expense_adjustment_entries: {
          value: 'category2_12',
          description: {
            en: 'Other Expense Adjustment/Regularisation Entries',
            el: 'Λοιπές Εγγραφές Τακτοποίησης Εξόδων' },
        },
        stock_at_period_start: {
          value: 'category2_13',
          description: {
            en: 'Stock at Period Start',
            el: 'Αποθέματα Έναρξης Περιόδου' },
        },
        stock_at_period_end: {
          value: 'category2_14',
          description: {
            en: 'Stock at Period End',
            el: 'Αποθέματα Λήξης Περιόδου' },
        },
        other_expense_related_information: {
          value: 'category2_95',
          description: {
            en: 'Other Expense-related Information',
            el: 'Λοιπά Πληροφοριακά Στοιχεία Εξόδων' },
        },
      },
      expense_classification_type: {
        E3_101_expense: {
          value: 'E3_101',
          description: {
            en: 'Commodities at Period Start',
            el: 'Εμπορεύματα Έναρξης' },
        },
        E3_102_001_expense: {
          value: 'E3_102_001',
          description: {
            en: 'Fiscal Year Commodity Purchases (net amount)/Wholesale',
            el: 'Αγορές εμπορευμάτων χρήσης (καθαρό ποσό)/Χονδρικές' },
        },
        E3_102_002_expense: {
          value: 'E3_102_002',
          description: {
            en: 'Fiscal Year Commodity Purchases (net amount)/Retail',
            el: 'Αγορές εμπορευμάτων χρήσης (καθαρό ποσό)/Λιανικές' },
        },
        E3_102_003_expense: {
          value: 'E3_102_003',
          description: {
            en: 'Fiscal Year Commodity Purchases (net amount)/Goods under article 39a paragraph 5 of the VAT Code (Law 2859/2000)',
            el: 'Αγορές εμπορευμάτων χρήσης (καθαρό ποσό)/Αγαθών του άρθρου 39α παρ.5 του Κώδικα Φ.Π.Α. (ν.2859/2000)' },
        },
        E3_102_004_expense: {
          value: 'E3_102_004',
          description: {
            en: 'Fiscal Year Commodity Purchases (net amount)/Foreign, Intra-Community',
            el: 'Αγορές εμπορευμάτων χρήσης (καθαρό ποσό)/Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_102_005_expense: {
          value: 'E3_102_005',
          description: {
            en: 'Fiscal Year Commodity Purchases (net amount)/Foreign, Third Countries',
            el: 'Αγορές εμπορευμάτων χρήσης (καθαρό ποσό)/Εξωτερικού Τρίτες Χώρες' },
        },
        E3_102_006_expense: {
          value: 'E3_102_006',
          description: {
            en: 'Fiscal Year Commodity Purchases (net amount)/Others',
            el: 'Αγορές εμπορευμάτων χρήσης (καθαρό ποσό)/Λοιπά' },
        },
        E3_104_expense: {
          value: 'E3_104',
          description: {
            en: 'Commodities at Period End',
            el: 'Εμπορεύματα Λήξης' },
        },
        E3_201_expense: {
          value: 'E3_201',
          description: {
            en: 'Raw and Other Materials at Period Start/Production',
            el: 'Πρώτες ύλες και λοιπά υλικά Έναρξης/Παραγωγή' },
        },
        E3_202_001_expense: {
          value: 'E3_202_001',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Wholesale',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Χονδρικές' },
        },
        E3_202_002_expense: {
          value: 'E3_202_002',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Retail',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Λιανικές' },
        },
        E3_202_003_expense: {
          value: 'E3_202_003',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Foreign, Intra-Community',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_202_004_expense: {
          value: 'E3_202_004',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Foreign, Third Countries',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Εξωτερικού Τρίτες Χώρες' },
        },
        E3_202_005_expense: {
          value: 'E3_202_005',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Others',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Λοιπά' },
        },
        E3_204_expense: {
          value: 'E3_204',
          description: {
            en: 'Raw and Other Material Stock at Period End/Production',
            el: 'Πρώτες ύλες και λοιπά υλικά Λήξης/Παραγωγή' },
        },
        E3_207_expense: {
          value: 'E3_207',
          description: {
            en: 'Products and Production in Progress at Period Start/Production',
            el: 'Προϊόντα και παραγωγή σε εξέλιξη Έναρξης/Παραγωγή' },
        },
        E3_209_expense: {
          value: 'E3_209',
          description: {
            en: 'Products and Production in Progress at Period End/Production',
            el: 'Προϊόντα και παραγωγή σε εξέλιξη λήξης/Παραγωγή' },
        },
        E3_301_expense: {
          value: 'E3_301',
          description: {
            en: 'Raw and Other Material at Period Start/Agricultural',
            el: 'Πρώτες ύλες και υλικά έναρξης/Αγροτική' },
        },
        E3_302_001_expense: {
          value: 'E3_302_001',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Wholesale',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Χονδρικές' },
        },
        E3_302_002_expense: {
          value: 'E3_302_002',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Retail',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Λιανικές' },
        },
        E3_302_003_expense: {
          value: 'E3_302_003',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Foreign, Intra-Community',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_302_004_expense: {
          value: 'E3_302_004',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Foreign, Third Countries',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Εξωτερικού Τρίτες Χώρες' },
        },
        E3_302_005_expense: {
          value: 'E3_302_005',
          description: {
            en: 'Fiscal Year Raw and Other Material Purchases (net amount)/Others',
            el: 'Αγορές πρώτων υλών και λοιπών υλικών χρήσης (καθαρό ποσό)/Λοιπά' },
        },
        E3_304_expense: {
          value: 'E3_304',
          description: {
            en: 'Raw and Other Material Stock at Period End/Agricultural',
            el: 'Αποθέματα λήξης πρώτων υλών και υλικών/Αγροτική' },
        },
        E3_307_expense: {
          value: 'E3_307',
          description: {
            en: 'Products and Production in Progress at Period Start/Agricultural',
            el: 'Προϊόντα και παραγωγή σε εξέλιξη έναρξης/Αγροτική' },
        },
        E3_309_expense: {
          value: 'E3_309',
          description: {
            en: 'Products and Production in Progress at Period End/Agricultural',
            el: 'Προϊόντα και παραγωγή σε εξέλιξη λήξης/Αγροτική' },
        },
        E3_312_expense: {
          value: 'E3_312',
          description: {
            en: 'Stock at Period Start (Animals-Plants)',
            el: 'Αποθέματα Έναρξης (Ζώα-Φυτά)' },
        },
        E3_313_001_expense: {
          value: 'E3_313_001',
          description: {
            en: 'Animal-Plant Purchases (net amount)/Wholesale',
            el: 'Αγορές ζώων - φυτών (καθαρό ποσό)/Χονδρικές' },
        },
        E3_313_002_expense: {
          value: 'E3_313_002',
          description: {
            en: 'Animal-Plant Purchases (net amount)/Retail',
            el: 'Αγορές ζώων - φυτών (καθαρό ποσό)/Λιανικές' },
        },
        E3_313_003_expense: {
          value: 'E3_313_003',
          description: {
            en: 'Animal-Plant Purchases (net amount)/Foreign, Intra-Community',
            el: 'Αγορές ζώων - φυτών (καθαρό ποσό)/Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_313_004_expense: {
          value: 'E3_313_004',
          description: {
            en: 'Animal-Plant Purchases (net amount)/Foreign, Third Countries',
            el: 'Αγορές ζώων - φυτών (καθαρό ποσό)/Εξωτερικού Τρίτες Χώρες' },
        },
        E3_313_005_expense: {
          value: 'E3_313_005',
          description: {
            en: 'Animal-Plant Purchases/Others',
            el: 'Αγορές ζώων - φυτών (καθαρό ποσό)/Λοιπά' },
        },
        E3_315_expense: {
          value: 'E3_315',
          description: {
            en: 'Stock at Period End (Animals-Plants)/Agricultural',
            el: 'Αποθέματα τέλους (ζώων - φυτών)/Αγροτική' },
        },
        E3_581_001_expense: {
          value: 'E3_581_001',
          description: {
            en: 'Employee Benefits/Gross Earnings',
            el: 'Παροχές σε εργαζόμενους/Μικτές αποδοχές' },
        },
        E3_581_002_expense: {
          value: 'E3_581_002',
          description: {
            en: 'Employee Benefits/Employer Contributions',
            el: 'Παροχές σε εργαζόμενους/Εργοδοτικές εισφορές' },
        },
        E3_581_003_expense: {
          value: 'E3_581_003',
          description: {
            en: 'Employee Benefits/Other Benefits',
            el: 'Παροχές σε εργαζόμενους/Λοιπές παροχές' },
        },
        E3_582_expense: {
          value: 'E3_582',
          description: {
            en: 'Asset Measurement Damages',
            el: 'Ζημιές επιμέτρησης περιουσιακών στοιχείων' },
        },
        E3_583_expense: {
          value: 'E3_583',
          description: {
            en: 'Debit Exchange Differences',
            el: 'Χρεωστικές συναλλαγματικές διαφορές' },
        },
        E3_584_expense: {
          value: 'E3_584',
          description: {
            en: 'Damages from Disposing-Withdrawing Non-Current Assets',
            el: 'Ζημιές από διάθεση-απόσυρση μη κυκλοφορούντων περιουσιακών στοιχείων' },
        },
        E3_585_001_expense: {
          value: 'E3_585_001',
          description: {
            en: 'Foreign/Domestic Management Fees',
            el: 'Προμήθειες διαχείρισης ημεδαπής - αλλοδαπής (management fees)' },
        },
        E3_585_002_expense: {
          value: 'E3_585_002',
          description: {
            en: 'Expenditures from Linked Enterprises',
            el: 'Δαπάνες από συνδεδεμένες επιχειρήσεις' },
        },
        E3_585_003_expense: {
          value: 'E3_585_003',
          description: {
            en: 'Expenditures from Non-Cooperative States or Privileged Tax Regimes',
            el: 'Δαπάνες από μη συνεργαζόμενα κράτη ή από κράτη με προνομιακό φορολογικό καθεστώς' },
        },
        E3_585_004_expense: {
          value: 'E3_585_004',
          description: {
            en: 'Expenditures for Information Day-Events',
            el: 'Δαπάνες για ενημερωτικές ημερίδες' },
        },
        E3_585_005_expense: {
          value: 'E3_585_005',
          description: {
            en: 'Reception and Hospitality Expenses',
            el: 'Έξοδα υποδοχής και φιλοξενίας' },
        },
        E3_585_006_expense: {
          value: 'E3_585_006',
          description: {
            en: 'Travel expenses',
            el: 'Έξοδα ταξιδιών' },
        },
        E3_585_007_expense: {
          value: 'E3_585_007',
          description: {
            en: 'Self-Employed Social Security Contributions',
            el: 'Ασφαλιστικές εισφορές αυτοαπασχολούμενων' },
        },
        E3_585_008_expense: {
          value: 'E3_585_008',
          description: {
            en: 'Commission Agent Expenses and Fees on behalf of Farmers',
            el: 'Έξοδα και προμήθειες παραγγελιοδόχου για λογαριασμό αγροτών' },
        },
        E3_585_009_expense: {
          value: 'E3_585_009',
          description: {
            en: 'Other Fees for Domestic Services',
            el: 'Λοιπές Αμοιβές για υπηρεσίες ημεδαπής' },
        },
        E3_585_010_expense: {
          value: 'E3_585_010',
          description: {
            en: 'Other Fees for Foreign Services',
            el: 'Λοιπές Αμοιβές για υπηρεσίες αλλοδαπής' },
        },
        E3_585_011_expense: {
          value: 'E3_585_011',
          description: {
            en: 'Energy',
            el: 'Ενέργεια' },
        },
        E3_585_012_expense: {
          value: 'E3_585_012',
          description: {
            en: 'Water',
            el: 'Ύδρευση' },
        },
        E3_585_013_expense: {
          value: 'E3_585_013',
          description: {
            en: 'Telecommunications',
            el: 'Τηλεπικοινωνίες' },
        },
        E3_585_014_expense: {
          value: 'E3_585_014',
          description: {
            en: 'Rents',
            el: 'Ενοίκια' },
        },
        E3_585_015_expense: {
          value: 'E3_585_015',
          description: {
            en: 'Advertisement and Promotion',
            el: 'Διαφήμιση και προβολή' },
        },
        E3_585_016_expense: {
          value: 'E3_585_016',
          description: {
            en: 'Other Expenses',
            el: 'Λοιπά έξοδα' },
        },
        E3_585_017_expense: {
          value: 'E3_585_017',
          description: {
            en: 'Miscellaneous Operating Expenses Z2',
            el: 'Διάφορα λειτουργικά έξοδα Ζ2' },
        },
        E3_586_expense: {
          value: 'E3_586',
          description: {
            en: 'Debit interests and related expenses',
            el: 'Χρεωστικοί τόκοι και συναφή έξοδα' },
        },
        E3_587_expense: {
          value: 'E3_587',
          description: {
            en: 'Amortisations',
            el: 'Αποσβέσεις' },
        },
        E3_588_expense: {
          value: 'E3_588',
          description: {
            en: 'Extraordinary expenses, damages and fines',
            el: 'Ασυνήθη έξοδα, ζημιές και πρόστιμα' },
        },
        E3_589_expense: {
          value: 'E3_589',
          description: {
            en: 'Provisions (except for Personnel Provisions)',
            el: 'Προβλέψεις (εκτός από προβλέψεις για το προσωπικό)' },
        },
        E3_882_001_expense: {
          value: 'E3_882_001',
          description: {
            en: 'Fiscal Year Tangible Asset Purchases/Wholesale',
            el: 'Αγορές Παγίων Ενεργητικών/Χονδρικές' },
        },
        E3_882_002_expense: {
          value: 'E3_882_002',
          description: {
            en: 'Fiscal Year Tangible Asset Purchases/Retail',
            el: 'Αγορές Παγίων Ενεργητικών/Λιανικές' },
        },
        E3_882_003_expense: {
          value: 'E3_882_003',
          description: {
            en: 'Fiscal Year Tangible Asset Purchases/Intra-Community Foreign',
            el: 'Αγορές ενσώματων παγίων χρήσης/Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_882_004_expense: {
          value: 'E3_882_004',
          description: {
            en: 'Fiscal Year Tangible Asset Purchases/Third Country Foreign',
            el: 'Αγορές ενσώματων παγίων χρήσης/Εξωτερικού Τρίτες Χώρες' },
        },
        E3_883_001_expense: {
          value: 'E3_883_001',
          description: {
            en: 'Fiscal Year Intangible Asset Purchases/Wholesale',
            el: 'Αγορές Απαραίτητων Ακινήτων/Χονδρικές' },
        },
        E3_883_002_expense: {
          value: 'E3_883_002',
          description: {
            en: 'Fiscal Year Intangible Asset Purchases/Retail',
            el: 'Αγορές Απαραίτητων Ακινήτων/Λιανικές' },
        },
        E3_883_003_expense: {
          value: 'E3_883_003',
          description: {
            en: 'Fiscal Year Intangible Asset Purchases/Intra-Community Foreign',
            el: 'Αγορές απαραίτητων ακινήτων/Εξωτερικού Ενδοκοινοτικές' },
        },
        E3_883_004_expense: {
          value: 'E3_883_004',
          description: {
            en: 'Fiscal Year Intangible Asset Purchases/Third Country Foreign',
            el: 'Αγορές απαραίτητων ακινήτων/Εξωτερικού Τρίτες Χώρες' },
        },
        VAT_361_expense: {
          value: 'VAT_361',
          description: {
            en: 'Domestic Purchases & Expenditures',
            el: 'Αγορές & δαπάνες στο εσωτερικό της χώρας' },
        },
        VAT_362_expense: {
          value: 'VAT_362',
          description: {
            en: 'Purchases & Imports of Investment Goods (Fixed Assets)',
            el: 'Αγορές & εισαγωγές επενδ. Αγαθών (πάγια)' },
        },
        VAT_363_expense: {
          value: 'VAT_363',
          description: {
            en: 'Other Imports except for Investment Goods (Fixed Assets)',
            el: 'Λοιπές εισαγωγές εκτός επενδ. Αγαθών (πάγια)' },
        },
        VAT_364_expense: {
          value: 'VAT_364',
          description: {
            en: 'Intra-Community Goods Acquisitions',
            el: 'Ενδοκοινοτικές αποκτήσεις αγαθών' },
        },
        VAT_365_expense: {
          value: 'VAT_365',
          description: {
            en: 'Intra-Community Services Receipts per article 14.2.a',
            el: 'Ενδοκοινοτικές λήψεις υπηρεσιών άρθρ. 14.2.α' },
        },
        VAT_366_expense: {
          value: 'VAT_366',
          description: {
            en: 'Other Recipient Actions',
            el: 'Λοιπές πράξεις λήπτη' },
        },
        E3_103_expense: {
          value: 'E3_103',
          description: {
            en: 'Impairment of goods',
            el: 'Απομείωση εμπορευμάτων' },
        },
        E3_203_expense: {
          value: 'E3_203',
          description: {
            en: 'Impairment of raw materials and supplies',
            el: 'Απομείωση πρώτων υλών και υλικών' },
        },
        E3_303_expense: {
          value: 'E3_303',
          description: {
            en: 'Impairment of raw materials and supplies',
            el: 'Απομείωση πρώτων υλών και υλικών' },
        },
        E3_208_expense: {
          value: 'E3_208',
          description: {
            en: 'Impairment of products and production in progress',
            el: 'Απομείωση προϊόντων και παραγωγής σε εξέλιξη' },
        },
        E3_308_expense: {
          value: 'E3_308',
          description: {
            en: 'Impairment of products and production in progress',
            el: 'Απομείωση προϊόντων και παραγωγής σε εξέλιξη' },
        },
        E3_314_expense: {
          value: 'E3_314',
          description: {
            en: 'Impairment of animals-plants - goods',
            el: 'Απομείωση ζώων - φυτών – εμπορευμάτων' },
        },
        E3_106_expense: {
          value: 'E3_106',
          description: {
            en: 'Own production of fixed assets – Self Deliveries – Inventory Disasters',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων' },
        },
        E3_205_expense: {
          value: 'E3_205',
          description: {
            en: 'Own production of fixed assets - Self Deliveries – Inventory Disasters',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων' },
        },
        E3_305_expense: {
          value: 'E3_305',
          description: {
            en: 'Own production of fixed assets - Self Deliveries – Inventory Disasters',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων' },
        },
        E3_210_expense: {
          value: 'E3_210',
          description: {
            en: 'Own production of fixed assets - Self Deliveries – Inventory Disasters',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων' },
        },
        E3_310_expense: {
          value: 'E3_310',
          description: {
            en: 'Own production of fixed assets - Self Deliveries – Inventory Disasters',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων' },
        },
        E3_318_expense: {
          value: 'E3_318',
          description: {
            en: 'Own production of fixed assets - Self Deliveries – Inventory Disasters',
            el: 'Ιδιοπαραγωγή παγίων - Αυτοπαραδόσεις - Καταστροφές αποθεμάτων' },
        },
        E3_598_002_expense: {
          value: 'E3_598_002',
          description: {
            en: 'Purchases of goods falling into excise duty',
            el: 'Αγορές αγαθών που υπάγονται σε ΕΦΚ' },
        },
        NOT_VAT_295_expense: {
          value: 'NOT_VAT_295',
          description: {
            en: 'Non-participation in VAT (expenses – inputs F2)',
            el: 'Μη συμμετοχή στο ΦΠΑ (έξοδα – εισροές Φ2)' },
        },
      }
    }.freeze

    def self.build_by_key
      by_value = {}
      BY_CATEGORY.each do |category, values|
        values.each do |key, value|
          if by_value.key?(key)
            raise "Duplicate key: #{key}"
          end
          by_value[key] = value.merge(category: category)
        end
      end
      by_value
    end

    BY_KEY = self.build_by_key

    class Constant
      attr_reader :category, :value, :description

      def initialize(value:, category:, description:)
        @value = value
        @category = category
        @description = description
      end

      def to_s(lang = :en)
        description[lang]
      end
    end

    def self.key?(key)
      BY_KEY.key?(key)
    end

    def self.fetch(key, category: nil)
      if category
        if data = BY_CATEGORY.dig(category, key)
          return Constant.new(value: data[:value], category: category, description: data[:description])
        end
      elsif data = BY_KEY[key]
        return Constant.new(value: data[:value], category: data[:category], description: data[:description])
      end
      return nil
    end

    def self.lookup_by_value(value, category:)
      BY_CATEGORY[category].each do |key, data|
        if data[:value] == value
          return Constant.new(value: value, category: category, description: data[:description])
        end
      end
      nil
    end

    def self.lookup_by_description(description, category:)
      BY_CATEGORY[category].each do |key, data|
        if data[:description][:en] == description || data[:description][:el] == description
          return Constant.new(value: data[:value], category: category, description: data[:description])
        end
      end
      nil
    end

    def self.validate!(key, category: nil)
      if c = fetch(key, category: category)
        return c.value
      end
      if category
        raise KeyError, "Unknown key in category #{category}: #{key}"
      else
        raise KeyError, "Unknown key: #{key}"
      end
    end

    def self.validate_value!(value, category:)
      if c = self.lookup_by_value(value, category: category)
        return c.value
      end
      raise(KeyError, "Unknown value in category #{category}: #{value}")
    end
  end
end

# rubocop:enable Layout/LineLength
