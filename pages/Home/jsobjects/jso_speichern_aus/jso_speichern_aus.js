export default {
    speichern: async () => {
        try {
            if (Table_aus.selectedRow.sid != null && Table_aus.selectedRow.sid !== "") {
                await update_rs_ausgabe.run();
                await insertAusgabe.run();
                await monatsliste_aus.run();
                await uebersicht_konto.run();
                await uebersicht_budget.run();
                await uebersicht_allgemein.run();
                resetWidget('InputArtikel_aus');
                resetWidget('InputBetrag_aus');
                resetWidget('SelectKategorie');
                resetWidget('SelectKonto_aus');
                resetWidget('DatePicker_aus');
                showAlert('Ausgabe aktualisiert ✅', 'success');
                removeValue("");
            } else {
                await insertAusgabe.run();
                await monatsliste_aus.run();
                await uebersicht_konto.run();
                await uebersicht_budget.run();
                await uebersicht_allgemein.run();
                resetWidget('InputArtikel_aus');
                resetWidget('InputBetrag_aus');
                resetWidget('SelectKategorie');
                resetWidget('SelectKonto_aus');
                resetWidget('DatePicker_aus');
                showAlert('Ausgabe gespeichert ✅', 'success');
                removeValue("");
            }
        } catch (e) {
            showAlert('Fehler beim Speichern ❌', 'error');
        }
    }
}