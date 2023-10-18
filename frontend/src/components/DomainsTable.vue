<template>
  <div>
    <div v-if="error" class="notification is-danger">
      Failed to load domains. Please try again later.
    </div>

    <div>
      <download-csv class="btn btn-default" :data="formattedDomains" name="domains.csv">
        <a href="#"> Export Domains </a>
      </download-csv>

      <vue-good-table styleClass="vgt-table" :columns="columns" :rows="formattedDomains" :search-options="{
        enabled: true
      }" :sort-options="{
  enabled: true,
}" />
    </div>
  </div>
</template>

<script>
import { VueGoodTable } from 'vue-good-table-next';
import JsonCSV from 'vue-json-csv'
import axios from "axios";

export default {
  components: {
    "downloadCsv": JsonCSV,
    VueGoodTable
  },
  methods: {
  },
  computed: {
    formattedDomains() {
      return this.domains.map(domain => ({
        ...domain,
        modified_on: new Date(domain.modified_on).toDateString()
      }));
    }
  },
  data() {
    return {
      columns: [
        {
          label: 'Domain Name',
          field: 'name',
        },
        {
          label: 'Value',
          field: 'content',
        },        
        {
          label: 'Modified Date',
          field: 'modified_on',
        },
        {
          label: 'Proxied',
          field: 'proxied',
        }        
      ],
      domains: [],
      error: false
    };
  },
  async mounted() {
    const PROXY_URL = process.env.VUE_APP_PROXY_URL || '/proxy/';

    try {
      console.log("Sending request to...", PROXY_URL)
      const response = await axios.get(PROXY_URL);
      this.domains = response.data.result;
    } catch (error) {
      console.error("There was an error!", error);
      this.error = true;
    }
  },
};
</script>

