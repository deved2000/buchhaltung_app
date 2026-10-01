export default {
    speichern: async () => {
        try {
            if (Table_tra.selectedRow?.sid != null && Table_tra.selectedRow?.sid !== "") {
                await update_rs_transaktion.run();
                await insertTransaktion.run();
                await monatsliste_tra.run();
                await uebersicht_konto.run();
                await uebersicht_budget.run();
                await uebersicht_allgemein.run();
                showAlert('Transaktion aktualisiert ✅', 'success');
                removeValue("");
            } else {
                await insertTransaktion.run();
                await monatsliste_tra.run();
                await uebersicht_konto.run();
                await uebersicht_budget.run();
                await uebersicht_allgemein.run();
                showAlert('Transaktion gespeichert ✅', 'success');
                removeValue("");
            }
        } catch (e) {
            showAlert('Fehler beim Speichern ❌', 'error');
        }
    }
}