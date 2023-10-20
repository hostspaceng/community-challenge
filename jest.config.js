import { mount } from '@vue/test-utils';
import HelloWorld from './HelloWorld.vue';

describe('HelloWorld.vue', () => {
  it('renders domains and export button', async () => {
    const wrapper = mount(HelloWorld);

    // Verify that domains are initially not displayed
    expect(wrapper.find('.vgt-table').exists()).toBe(false);
    expect(wrapper.find('.btn.btn-default').exists()).toBe(false);

    // Simulate a successful API response
    await wrapper.setData({ domains: [{ name: 'example.com', content: '123.45.67.89', modified_on: '2023-10-20', proxied: true }] });

    // Verify that domains are displayed
    expect(wrapper.find('.vgt-table').exists()).toBe(true);
    expect(wrapper.find('.btn.btn-default').exists()).toBe(true);
  });

  it('displays an error message on API request failure', async () => {
    const wrapper = mount(HelloWorld);

    // Simulate an API request failure
    await wrapper.setData({ error: true });

    // Verify that the error message is displayed
    expect(wrapper.find('.notification.is-danger').exists()).toBe(true);
  });

  it('exports domains as CSV', async () => {
    const wrapper = mount(HelloWorld);

    // Simulate a successful API response
    await wrapper.setData({ domains: [{ name: 'example.com', content: '123.45.67.89', modified_on: '2023-10-20', proxied: true }] });

    // Trigger the export button click
    await wrapper.find('.btn.btn-default').trigger('click');

    // TODO: Add assertions for the CSV export behavior
    // You may want to check that the CSV export is triggered correctly.
    // This may require a custom assertion depending on how your 'download-csv' component works.
  });
});
