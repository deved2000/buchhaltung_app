export default {
    speichern: async () => {
        try {
            if (Table_ein.selectedRow.sid != null && Table_ein.selectedRow.sid !== "") {
                await update_rs_einnahme.run();
                await insertEinnahme.run();
                await uebersicht_konto.run();
                await uebersicht_budget.run();
                await uebersicht_allgemein.run();
                await monatsliste_ein.run();
                resetWidget('Table_ein');
                showAlert('Einnahme aktualisiert ✅', 'success');
                removeValue("");
            } else {
                await insertEinnahme.run();
                await uebersicht_konto.run();
                await uebersicht_budget.run();
                await uebersicht_allgemein.run();
                await monatsliste_ein.run();
                resetWidget('Table_ein');
                showAlert('Einnahme gespeichert ✅', 'success');
                removeValue("");
            }
        } catch (e) {
            showAlert('Fehler beim Speichern ❌', 'error');
        }
    }
}